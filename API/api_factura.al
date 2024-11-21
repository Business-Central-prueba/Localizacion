page 50107 api_Factura
{
    APIGroup = 'Localizacion';
    APIPublisher = 'KIS';
    APIVersion = 'v2.0';
    Caption = 'apiFactura';
    DelayedInsert = true;
    EntityName = 'factura';
    EntitySetName = 'factura';
    PageType = API;
    SourceTable = "Sales Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(blobPDF; Rec."Blob PDF")
                {
                    Caption = 'PDF';
                }
                field(workDescription; Rec."Work Description")
                {
                    Caption = 'Work Description';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
            }
        }
    }
}
