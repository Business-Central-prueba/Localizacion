page 50165 "Subcategoría act. económicas"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SubCategoriaActividad;
    CardPageId = "Subcategoría act. económicas";


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codigoSubCategoria; Rec.codigo_Subcategoria)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Código de subcategoria de la actividad económica.';
                    Caption = 'Código Subcategoría económica';
                }

                field(nombreSubCategorias; Rec.nombreSubCategorias)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Nombre de la subcategoria de la actividad económica.';
                    Caption = 'Nombre Subcategoría económica';

                }

                field(codigoCategoria; Rec.Codigo_Categoria)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Código de la categoría al que está vinculado la subcategoría.';
                    Caption = 'Código categoría económica';
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
                        ActEconomica: Record SubCategoriaActividad;
                        ReestablecerTabla: Codeunit InstalacionAplicacion;
                    begin
                        ActEconomica.DeleteAll();
                        ReestablecerTabla.LlenadodeTablasSubcategoriaEconomica();
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

                action("Ir a página Actividades económicas")
                {
                    ApplicationArea = All;
                    RunObject = page "Actividades Económicas";
                }

            }
        }
    }

}