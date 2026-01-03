const toggleSidebar=() =>{
    const sidebar = document.getElementById('sidebar');
    sidebar.classList.toggle('collapsed');
}

const closeSidebar=() =>{
    const sidebar = document.getElementById('sidebar');
        sidebar.classList.add('collapsed');

}
