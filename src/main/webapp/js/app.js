function notifyApp(message, type) {
    var text = message || "";
    if (!text) {
        return;
    }

    var container = document.getElementById("toastContainer");
    if (!container) {
        container = document.createElement("div");
        container.id = "toastContainer";
        container.className = "toast-container position-fixed top-0 end-0 p-3";
        container.setAttribute("aria-live", "polite");
        container.setAttribute("aria-atomic", "true");
        document.body.appendChild(container);
    }

    var toast = document.createElement("div");
    var tone = type === "error" ? "text-bg-danger" : "text-bg-primary";
    toast.className = "toast align-items-center border-0 " + tone;
    toast.setAttribute("role", "alert");
    toast.innerHTML = '<div class="d-flex">'
        + '<div class="toast-body"></div>'
        + '<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>'
        + '</div>';
    toast.querySelector(".toast-body").textContent = text;
    container.appendChild(toast);

    var instance = bootstrap.Toast.getOrCreateInstance(toast, { delay: 2600 });
    toast.addEventListener("hidden.bs.toast", function () {
        toast.remove();
    });
    instance.show();
}

function confirmApp(message, onConfirm) {
    var labels = window.I18N || {};
    var modal = document.getElementById("confirmModal");
    if (!modal) {
        modal = document.createElement("div");
        modal.id = "confirmModal";
        modal.className = "modal fade";
        modal.tabIndex = -1;
        modal.innerHTML = '<div class="modal-dialog modal-dialog-centered">'
            + '<div class="modal-content">'
            + '<div class="modal-header">'
            + '<h2 class="modal-title fs-5" data-confirm-title></h2>'
            + '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>'
            + '</div>'
            + '<div class="modal-body"><p class="mb-0" data-confirm-message></p></div>'
            + '<div class="modal-footer">'
            + '<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" data-confirm-cancel></button>'
            + '<button type="button" class="btn btn-danger" data-confirm-ok></button>'
            + '</div>'
            + '</div>'
            + '</div>';
        document.body.appendChild(modal);
    }

    modal.querySelector("[data-confirm-title]").textContent = labels.confirmTitle || "Confirm";
    modal.querySelector("[data-confirm-message]").textContent = message || "";
    modal.querySelector("[data-confirm-cancel]").textContent = labels.cancel || "Cancel";
    var okButton = modal.querySelector("[data-confirm-ok]");
    okButton.textContent = labels.confirm || "Confirm";
    $(okButton).off("click").on("click", function () {
        bootstrap.Modal.getOrCreateInstance(modal).hide();
        if (typeof onConfirm === "function") {
            onConfirm();
        }
    });
    bootstrap.Modal.getOrCreateInstance(modal).show();
}

function logoutApp(contextPath) {
    deleteRequest(contextPath + "/api/session", {}, function () {
        window.location.href = contextPath + "/";
    });
}
