page 50154 "Documento compra"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DocumentoCompras;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codigoDocCompra;Rec.codigoDocCompra)
                {
                    ApplicationArea = All;
                }

                field(nombreDocumentoCompra;Rec.nombreDocumentoCompra)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction();
                begin
                    
                end;
            }
        }
    }
}