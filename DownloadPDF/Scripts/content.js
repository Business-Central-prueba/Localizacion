window.addEventListener('message', function(event) {
    if (event.data) {
        console.log('Mensaje recibido desde AL:', event.data);
        alert('Mensaje recibido desde AL: ' + event.data);
    }
});
// Cargar la página control.html dentro del ControlAddIn
(function ($) {
    $(document).ready(function () {
        var url = Microsoft.Dynamics.NAV.GetImageResource("DownloadPDF/html/control.html");
        $("#controlAddIn").load(url);
    });
})(jQuery);