page 50160 "Actividades Económicas"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = actividadEconomica;
    CardPageId = "Agregar Actividad Economica";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codigoActividad; Rec.codigoActividad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Código verificador de actividad económica asignado por el SII.';
                    Caption = 'Código Actividad económica';
                }

                field(nombreActividad; Rec.nombre_Actividad)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Nombre de la actividad económica.';
                    Caption = 'Actividad económica';

                }

                field(categoriaActividad; Rec.Categoria_Economica)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Código vinculado a la categoría de la actividad económica.';
                    Caption = 'Código Categoría actividad económica';
                }

                field(subCategoriaActividad; Rec.Subcategoria_Economica)
                {
                    ApplicationArea = All;
                    Caption = 'Código Subcategoría actividad económica';
                    ToolTip = 'Localización Chilena. Código vinculado a la subcategoría de la actividad económica.';
                }
            }
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
                        ActEconomica: Record actividadEconomica;
                        ReestablecerTabla: Codeunit InstalacionAplicacion;
                    begin
                        ActEconomica.DeleteAll();
                        ReestablecerTabla.LlenadodeTablasActividadEconomica();
                        Message('Se ha reestablecido tabla correctamente');
                    end;
                }
            }
            group("Ver tablas relacionadas")
            {

                action("Ir a página categorías actividades económicas")
                {
                    ApplicationArea = All;
                    RunObject = page "Categorias Act. Económicas";
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