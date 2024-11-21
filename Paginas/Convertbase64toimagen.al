page 50999 "Picture Encoded Text Dialog 1"
{
    PageType = StandardDialog;
    Caption = 'Picture Encoded Text Dialog';

    layout
    {
        area(content)
        {
            field(ItemNo; ItemNo)
            {
                ApplicationArea = All;
                Caption = 'Item No.';
                Editable = false;
            }
            field(ItemDesc; ItemDesc)
            {
                ApplicationArea = All;
                Caption = 'Item Description';
                Editable = false;
            }
            field(PictureEncodedTextDialog; PictureEncodedTextDialog)
            {
                ApplicationArea = All;
                Caption = 'Picture Encoded Text';
                MultiLine = true;
            }
        }
    }

    var
        ItemNo: Code[20];
        ItemDesc: Text[100];
        PictureEncodedTextDialog: Text;

        RecordRef: RecordRef;

    procedure SetItemInfo(NewItemNo: Code[20]; NewItemDesc: Text[100])
    begin
        ItemNo := NewItemNo;
        ItemDesc := NewItemDesc;
    end;

    procedure ImportPictureFromiEncodedText()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
        InStr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        RecordLink: Record "Record Link";
        SalesHeader: Record "Sales Header";
        MediaManagement: Codeunit "Media Resources Mgt.";
        OverrideImageQst: Label 'La imagen existente será reemplazada. ¿Desea continuar?';
        MustSpecifyDescriptionErr: Label 'Debe agregar una descripción a la factura antes de poder importar una imagen.';
        Base64Convert: Codeunit "Base64 Convert";
        MediaID: Guid;
    begin
        if SalesHeader.Get(SalesHeader."No.") then begin
            if SalesHeader.Folio = 0 then
                Error(MustSpecifyDescriptionErr);

            if SalesHeader."Blob PDF".HasValue then
                if not Confirm(OverrideImageQst) then
                    Error('');

            FileName := ItemDesc + '.pdf';

            // Crear el stream del archivo desde la cadena base64
            TempBlob.CreateOutStream(OutStr);
            Base64Convert.FromBase64(PictureEncodedTextDialog, OutStr);
            TempBlob.CreateInStream(InStr);

            // Usar la funcionalidad de Media Management para crear un archivo Media desde el Blob
            //MediaID := MediaManagement.InsertMediaFromInstream(FileName, InStr); // 'application/pdf' es el content type

            // Guardar el archivo en la tabla "Record Link"
            RecordLink.Init();
            RecordLink."Record ID" := SalesHeader.RecordId;
            //RecordLink.URL1 := MediaID.ToString();
            RecordLink.Description := 'Imagen convertida desde base64';
            RecordLink.Insert();
        end;
    end;
}
