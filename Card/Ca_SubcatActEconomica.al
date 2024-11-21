page 50155 "Agregar Sub Catgoria"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = SubCategoriaActividad;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codigoSubCategoria; Rec.codigo_Subcategoria)
                {
                    ApplicationArea = All;
                }

                field(nombreSubCategorias; Rec.nombreSubCategorias)
                {
                    ApplicationArea = All;
                }

                field(codigoCategoria; Rec.Codigo_Categoria)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemRec: Record CategoriaActividadEconomica;
                    begin
                        ItemRec.Reset();
                        if Page.RunModal(Page::"Categorias Act. Económicas", ItemRec) = Action::LookupOK then
                            Rec.Codigo_Categoria := ItemRec.codigo_Categoria;
                    end;
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