import express from "express";
import cors from "cors";
import session from "express-session";
import mysql from "mysql2/promise";
import bcrypt from "bcryptjs";
import dotenv from "dotenv";

dotenv.config();

const app = express();
const PORT = Number(process.env.PORT || 3000);

const pool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "",
  database: process.env.DB_NAME || "rastreo_ambiental",
  waitForConnections: true,
  connectionLimit: 10,
});

app.use(cors({
  origin: process.env.CLIENT_URL || "http://localhost:5173",
  credentials: true,
}));
app.use(express.json());
app.use(session({
  secret: process.env.SESSION_SECRET || "cambia-esta-clave",
  resave: false,
  saveUninitialized: false,
  cookie: { httpOnly: true, sameSite: "lax", secure: false },
}));

app.get("/api/health", (_req, res) => res.json({ ok: true, message: "API funcionando" }));

app.post("/api/login", async (req, res) => {
  try {
    const { correo, password } = req.body;
    if (!correo || !password) return res.status(400).json({ message: "Correo y contraseña son obligatorios." });

    const [rows] = await pool.execute(
      "SELECT id_usuario, nombre, password, tipo_usuario FROM usuario WHERE correo = ? LIMIT 1",
      [correo]
    );
    const usuario = rows[0];

    if (!usuario) return res.status(401).json({ message: "Correo no encontrado." });

    const valid = await bcrypt.compare(password, usuario.password);
    if (!valid) return res.status(401).json({ message: "Contraseña incorrecta." });

    req.session.user = {
      id_usuario: usuario.id_usuario,
      nombre: usuario.nombre,
      tipo_usuario: usuario.tipo_usuario,
    };

    res.json({ message: "Inicio de sesión correcto.", user: req.session.user });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error del servidor al iniciar sesión." });
  }
});

app.post("/api/register", async (req, res) => {
  const connection = await pool.getConnection();
  try {
    const {
      nombre, apellido, correo, password, telefono, direccion, tipo_usuario,
      num_documento, licencia, vehiculo_asignado, cargo, dependencia, nivel_acceso
    } = req.body;

    if (!nombre || !apellido || !correo || !password || !tipo_usuario) {
      return res.status(400).json({ message: "Completa los campos obligatorios." });
    }

    await connection.beginTransaction();

    const [existing] = await connection.execute(
      "SELECT id_usuario FROM usuario WHERE correo = ? LIMIT 1",
      [correo]
    );
    if (existing.length) {
      await connection.rollback();
      return res.status(409).json({ message: "El correo ya está registrado." });
    }

    const passwordHash = await bcrypt.hash(password, 10);

    const [result] = await connection.execute(
      `INSERT INTO usuario
       (nombre, apellido, correo, password, telefono, direccion, tipo_usuario)
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [nombre, apellido, correo, passwordHash, telefono || null, direccion || null, tipo_usuario]
    );

    const id_usuario = result.insertId;

    if (tipo_usuario === "ciudadano") {
      await connection.execute("INSERT INTO ciudadano (id_usuario) VALUES (?)", [id_usuario]);
    }

    if (tipo_usuario === "funcionario") {
      await connection.execute(
        "INSERT INTO funcionario (id_usuario, cargo, dependencia) VALUES (?, ?, ?)",
        [id_usuario, cargo || null, dependencia || null]
      );
    }

    if (tipo_usuario === "administrador") {
      await connection.execute(
        "INSERT INTO administrador (id_usuario, nivel_acceso) VALUES (?, ?)",
        [id_usuario, nivel_acceso || "basico"]
      );
    }

    if (tipo_usuario === "conductor") {
      await connection.execute(
        "INSERT INTO conductor (id_usuario, num_documento, licencia, vehiculo_asignado) VALUES (?, ?, ?, ?)",
        [id_usuario, num_documento || null, licencia || null, vehiculo_asignado || null]
      );
    }

    await connection.commit();
    res.status(201).json({ message: "Registro realizado correctamente." });
  } catch (error) {
    await connection.rollback();
    console.error(error);
    res.status(500).json({ message: "No se pudo registrar el usuario." });
  } finally {
    connection.release();
  }
});

app.post("/api/logout", (req, res) => {
  req.session.destroy(() => {
    res.json({ message: "Sesión cerrada." });
  });
});

app.get("/api/session", (req, res) => {
  res.json({ user: req.session.user || null });
});

app.listen(PORT, () => {
  console.log(`API Rastreo Ambiental ejecutándose en http://localhost:${PORT}`);
});
