function onMenuToggle(btn) {
    const icon = btn.querySelector("i");
    const targetId = btn.getAttribute("data-bs-target");
    const target = document.querySelector(targetId);

    // Close all other open menus
    document.querySelectorAll(".collapse.show").forEach(menu => {
        if (menu !== target) {
            menu.classList.remove("show");

            const otherBtn = document.querySelector(
                `[data-bs-target="#${menu.id}"]`
            );
            if (otherBtn) {
                otherBtn.classList.remove("bg-primary", "bg-opacity-10");
                const otherIcon = otherBtn.querySelector("i");
                if (otherIcon) {
                    otherIcon.classList.remove("bi-chevron-up");
                    otherIcon.classList.add("bi-chevron-down");
                }
            }
        }
    });

    // Toggle current menu styles after Bootstrap runs
    setTimeout(() => {
        const isOpen = target.classList.contains("show");

        btn.classList.toggle("bg-primary", isOpen);
        btn.classList.toggle("bg-opacity-10", isOpen);

        icon.classList.toggle("bi-chevron-up", isOpen);
        icon.classList.toggle("bi-chevron-down", !isOpen);
    }, 50);
}

// Sidebar toggle (hamburger)
function toggleSidebar() {
    const sidebar = document.getElementById("pnlSidebar");
    if (sidebar) sidebar.classList.toggle("d-none");
}

// Auto close on mobile click
function closeSidebar() {
    const sidebar = document.getElementById("pnlSidebar");
    if (sidebar && window.innerWidth < 992) {
        sidebar.classList.add("d-none");
    }
}
