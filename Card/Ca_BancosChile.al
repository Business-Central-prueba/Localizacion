page 50156 "Agregar Banco Chile"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Bancos;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                
                field(codigoBanco;Rec.codigoBanco)
                {
                    ApplicationArea = All;
                }
                
                field(nombreBanco;Rec.nombreBanco){
                    ApplicationArea = All;
                }

                field(opcionTipoBancos;Rec.Opcion_Tipo_Banco){
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