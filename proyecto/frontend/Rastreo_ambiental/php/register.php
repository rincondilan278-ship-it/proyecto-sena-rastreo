<?php

require_once("../config/conexion.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    try {

        /* DATOS GENERALES */

        $nombre = $_POST["nombre"];
        $apellido = $_POST["apellido"];
        $correo = $_POST["correo"];
        $password = $_POST["password"];
        $telefono = $_POST["telefono"];
        $direccion = $_POST["direccion"];
        $tipo_usuario = $_POST["tipo_usuario"];


        /* ENCRIPTAR CONTRASEÑA */

        $password_hash = password_hash($password, PASSWORD_DEFAULT);


        /* INSERT USUARIO */

        $sql = "INSERT INTO usuario
        (nombre, apellido, correo, password, telefono, direccion, tipo_usuario)

        VALUES

        (:nombre, :apellido, :correo, :password, :telefono, :direccion, :tipo_usuario)";


        $stmt = $conexion->prepare($sql);

        $stmt->bindParam(":nombre", $nombre);
        $stmt->bindParam(":apellido", $apellido);
        $stmt->bindParam(":correo", $correo);
        $stmt->bindParam(":password", $password_hash);
        $stmt->bindParam(":telefono", $telefono);
        $stmt->bindParam(":direccion", $direccion);
        $stmt->bindParam(":tipo_usuario", $tipo_usuario);

        $stmt->execute();


        /* ID GENERADO */

        $id_usuario = $conexion->lastInsertId();


        /* SEGUN EL TIPO DE USUARIO */

        if ($tipo_usuario == "ciudadano") {

            $sql_ciudadano = "INSERT INTO ciudadano(id_usuario)
                              VALUES(:id_usuario)";

            $stmt = $conexion->prepare($sql_ciudadano);

            $stmt->bindParam(":id_usuario", $id_usuario);

            $stmt->execute();
        }



        if ($tipo_usuario == "funcionario") {

            $cargo = $_POST["cargo"];
            $dependencia = $_POST["dependencia"];


            $sql_funcionario = "INSERT INTO funcionario
            (id_usuario, cargo, dependencia)

            VALUES

            (:id_usuario, :cargo, :dependencia)";


            $stmt = $conexion->prepare($sql_funcionario);

            $stmt->bindParam(":id_usuario", $id_usuario);
            $stmt->bindParam(":cargo", $cargo);
            $stmt->bindParam(":dependencia", $dependencia);

            $stmt->execute();
        }



        if ($tipo_usuario == "administrador") {

            $nivel_acceso = $_POST["nivel_acceso"];


            $sql_admin = "INSERT INTO administrador
            (id_usuario, nivel_acceso)

            VALUES

            (:id_usuario, :nivel_acceso)";


            $stmt = $conexion->prepare($sql_admin);

            $stmt->bindParam(":id_usuario", $id_usuario);
            $stmt->bindParam(":nivel_acceso", $nivel_acceso);

            $stmt->execute();
        }



        if ($tipo_usuario == "conductor") {

            $num_documento = $_POST["num_documento"];
            $licencia = $_POST["licencia"];
            $vehiculo_asignado = $_POST["vehiculo_asignado"];


            $sql_conductor = "INSERT INTO conductor
            (id_usuario, num_documento, licencia, vehiculo_asignado)

            VALUES

            (:id_usuario, :num_documento, :licencia, :vehiculo_asignado)";


            $stmt = $conexion->prepare($sql_conductor);

            $stmt->bindParam(":id_usuario", $id_usuario);
            $stmt->bindParam(":num_documento", $num_documento);
            $stmt->bindParam(":licencia", $licencia);
            $stmt->bindParam(":vehiculo_asignado", $vehiculo_asignado);

            $stmt->execute();
        }



        /* REDIRECCION */

        echo "<script>

            alert('Registro realizado correctamente');

            window.location='../login.html';

        </script>";


    } catch (PDOException $e) {

        echo "<script>

            alert('Error: " . $e->getMessage() . "');

            window.history.back();

        </script>";
    }
}

?>