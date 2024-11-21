page 50158 "Agregar Tipo Documento"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = tipoDocumentos;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(DTE;Rec.DTE)
                {
                    ApplicationArea = All;
                }
                
                field(Tipo;Rec.Tipo)
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