page 50150 "Agregar Actividad Economica"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ActividadEconomica;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codigoActividad; Rec.codigoActividad)
                {
                    ApplicationArea = All;

                }

                field(nombreActividad; Rec.nombre_Actividad)
                {
                    ApplicationArea = All;

                }

                field(categoriaActividad; Rec.Categoria_Economica)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        // Relación con tabla para obtener su data
                        ItemRec: Record CategoriaActividadEconomica;
                    begin
                        // Reiniciar tabla
                        ItemRec.Reset();
                        // Abrir "Page Card", no la "Page List"
                        if Page.RunModal(Page::"Categorias Act. Económicas", ItemRec) = Action::LookupOK then
                            // Set RunModal desde la caolumna "categoriaActividad", muestra toda la data de la tabla, no solo su "Id"
                            Rec.Categoria_Economica := ItemRec.codigo_Categoria;
                    end;
                }

                field(subCategoriaActividad; Rec.Subcategoria_Economica)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemRec: Record SubCategoriaActividad;
                    begin
                        ItemRec.Reset();
                        if Page.RunModal(Page::"Subcategoría act. económicas", ItemRec) = Action::LookupOK then
                            Rec.Subcategoria_Economica := ItemRec.nombreSubCategorias;
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