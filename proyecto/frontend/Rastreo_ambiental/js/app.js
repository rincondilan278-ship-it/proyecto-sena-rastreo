document.addEventListener("DOMContentLoaded", function () {

    const tipoUsuario = document.getElementById("tipo_usuario");
    const conductor = document.getElementById("conductorFields");
    const funcionario = document.getElementById("funcionarioFields");
    const admin = document.getElementById("adminFields");

    function ocultarCampos() {
        if (conductor) conductor.style.display = "none";
        if (funcionario) funcionario.style.display = "none";
        if (admin) admin.style.display = "none";
    }

    function mostrarCampos() {
        ocultarCampos();

        if (!tipoUsuario) return;

        if (tipoUsuario.value === "conductor")
            conductor.style.display = "block";

        if (tipoUsuario.value === "funcionario")
            funcionario.style.display = "block";

        if (tipoUsuario.value === "administrador")
            admin.style.display = "block";
    }

    if (tipoUsuario) {
        ocultarCampos();
        tipoUsuario.addEventListener("change", mostrarCampos);
    }

    const loginForm = document.getElementById("loginForm");

    if (loginForm) {
        loginForm.addEventListener("submit", function () {
            console.log("Intentando iniciar sesión...");
        });
    }

});