page 50162 "Categoria Act. Económicas"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CategoriaActividadEconomica;
    CardPageId = "Categoria Act. Económicas";

    layout
    {
        area(Content)
        {
            repeater("Categorías económicas")
            {
                field(codigoCategoria; Rec.codigo_Categoria)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Código de la actividad económica';
                    Caption = 'Código categoría económica';
                }

                field(nombreCategoria; Rec.nombreCategoria)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Nombre de la categoría de cada actividad económica.';
                    Caption = 'Nombre categoría actividad económica';
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
            group("Administración de tabla")
            {
                action("Reestablecer tabla por defecto")
                {
                    ApplicationArea = All;
                    ToolTip = 'Limpiar tabla a contenido por defecto.';
                    trigger OnAction()
                    var
                        ActEconomica: Record CategoriaActividadEconomica;
                        ReestablecerTabla: Codeunit InstalacionAplicacion;
                    begin
                        ActEconomica.DeleteAll();
                        ReestablecerTabla.LlenadodeTablasCategoriaEconomica();
                        Message('Se ha reestablecido tabla correctamente');
                    end;
                }
            }
            group("Ver lista tablas relacionadas")
            {

                action("Ir a página Actividades económicas")
                {
                    ApplicationArea = All;
                    RunObject = page "Actividades Económicas";
                }

                action("Ir a página Subcategorías actividades económicas")
                {
                    ApplicationArea = All;
                    RunObject = page "Subcategoría act. económicas";
                }

            }
        }
    }
}