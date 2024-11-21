page 50161 "Tipos de Banco"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = tipoBanco;
    CardPageId = "Agregar Tipo de Banco";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codigoTipoBanco; Rec.Codigo_Tipo_Banco)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Código de los tipos de bancos existentes en Chile.';
                    Caption = 'Código tipo banco';
                }
                field(nombreBanco; Rec.nombreBanco)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Tipo de banco exitente en Chile.';
                    Caption = 'Nombre de banco';
                }
                field(descripcionTipoBanco; Rec.descripcionTipoBanco)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Descripción respecto al tipo de banco a nivel país.';
                    Caption = 'Descripción tipo banco';
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
                        TipoBanco: Record tipoBanco;
                        ReestablecerTabla: Codeunit InstalacionAplicacion;
                    begin
                        TipoBanco.DeleteAll();
                        ReestablecerTabla.LlenadodeTablaTipoBanco();
                        Message('Se ha reestablecido tabla con éxito');
                    end;
                }
            }
            group("Ver tablas relacionadas")
            {

                action("Ir a página de Bancos Chile")
                {
                    ApplicationArea = All;
                    RunObject = page "Bancos Chile";
                }


            }
        }
    }
}