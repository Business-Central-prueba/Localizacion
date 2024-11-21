controladdin "Control"
{
    Scripts =
        'https://ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.0.min.js',
        'DownloadPDF/Scripts/content.js';

    Images = 'DownloadPDF/html/control.html';

    StyleSheets = 'DownloadPDF/Stylesheets/pdf.css';

    HorizontalStretch = true;
    VerticalStretch = true;

    // Declaración del método para recibir mensajes
    procedure SendMessage(Message: Text);
}
