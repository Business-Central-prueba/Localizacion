page 50153 "Documento venta"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DocumentoVentas;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codigoDocVenta; Rec.codigoDocVenta )
                {
                    ApplicationArea = All;
                }

                field(nombreDocumentoVenta; Rec.nombreDocumentoVenta )
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