import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { login } from "../../services/api";
import logo from "../../assets/ambiental2.png";
import "../../css/index.css";

export default function Login() {
  const navigate = useNavigate();

  const [correo, setCorreo] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");

  const [loading, setLoading] = useState(false);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();

    setError("");
    setLoading(true);
    try {
      const result = await login(correo, password);
      localStorage.setItem("usuario", JSON.stringify({ ...result.user, correo }));
      const role = result.user.tipo_usuario;
      navigate(`/${role}/dashboard`);
    } catch (err) {
      setError(err instanceof Error ? err.message : "No se pudo iniciar sesión.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="login-page">
      <div className="login-container">
        <div className="logo-area">
          <img src={logo} alt="Logo" />
          <h1>RASTREO AMBIENTAL</h1>
          <p>Crear nueva cuenta</p>
        </div>

        <h1>Iniciar sesión</h1>

        <form
          className="login-form"
          onSubmit={handleLogin}
        >

          <div>
            <label htmlFor="correo">
              Correo electrónico
            </label>

            <input
              id="correo"
              type="email"
              value={correo}
              onChange={(e) => setCorreo(e.target.value)}
              placeholder="Correo electrónico"
              required
            />
          </div>

          <div>
            <label htmlFor="password">
              Contraseña
            </label>

            <input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Contraseña"
              required
            />
          </div>

          {error && (
            <p className="login-error">
              {error}
            </p>
          )}

          <button
            type="submit"
            className="login-button"
          >
            {loading ? "Ingresando..." : "Iniciar sesión"}
          </button>

        </form>

      </div>
    </div>
  );
}