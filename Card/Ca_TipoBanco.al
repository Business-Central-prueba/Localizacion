page 50151 "Agregar Tipo de Banco"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = tipoBanco;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codigoTipoBanco; Rec.Codigo_Tipo_Banco)
                {
                    ApplicationArea = All;
                }

                field(nombreBanco; Rec.nombreBanco)
                {
                    ApplicationArea = All;
                }
                field(descripcionTipoBanco; Rec.descripcionTipoBanco)
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