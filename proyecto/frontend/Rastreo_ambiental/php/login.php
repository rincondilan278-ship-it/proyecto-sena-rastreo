<?php

session_start();

require_once("../config/conexion.php");


if ($_SERVER["REQUEST_METHOD"] == "POST") {

    try {

        $correo = $_POST["correo"];
        $password = $_POST["password"];


        /* BUSCAR USUARIO */

        $sql = "SELECT * FROM usuario
                WHERE correo = :correo";

        $stmt = $conexion->prepare($sql);

        $stmt->bindParam(":correo", $correo);

        $stmt->execute();

        $usuario = $stmt->fetch(PDO::FETCH_ASSOC);


        /* VERIFICAR SI EXISTE */

        if ($usuario) {

            /* COMPARAR PASSWORD */

            if (password_verify($password, $usuario["password"])) {

                /* CREAR SESION */

                $_SESSION["id_usuario"] = $usuario["id_usuario"];
                $_SESSION["nombre"] = $usuario["nombre"];
                $_SESSION["tipo_usuario"] = $usuario["tipo_usuario"];


                /* REDIRECCION SEGUN ROL */

                if ($usuario["tipo_usuario"] == "administrador") {

                    header("Location: ../administrador/dashboard.html");
                    exit();
                }


                if ($usuario["tipo_usuario"] == "funcionario") {

                    header("Location: ../funcionario/dashboard.html");
                    exit();
                }


                if ($usuario["tipo_usuario"] == "ciudadano") {

                    header("Location: ../ciudadano/dashboard.html");
                    exit();
                }


                if ($usuario["tipo_usuario"] == "conductor") {

                    header("Location: ../conductor/dashboard.html");
                    exit();
                }

            } else {

                echo "<script>

                    alert('Contraseña incorrecta');

                    window.location='../login.html';

                </script>";
            }

        } else {

            echo "<script>

                alert('Correo no encontrado');

                window.location='../login.html';

            </script>";
        }

    } catch (PDOException $e) {

        echo "<script>

            alert('Error: " . $e->getMessage() . "');

            window.location='../login.html';

        </script>";
    }
}

?>