page 50157 "Agregar Tipo Transaccion"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = tipoTransaccion;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(idTransaccion;Rec.Id_Transaccion)
                {
                    ApplicationArea = All;
                }
                
                field(descripcionTransaccion;Rec.descripcionTransaccion)
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