page 50152 "Categorias Act. Económicas"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CategoriaActividadEconomica;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codigoCategoria;Rec.codigo_Categoria)
                {
                    ApplicationArea = All;
                }

                field(nombreCategoria;Rec.nombreCategoria)
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