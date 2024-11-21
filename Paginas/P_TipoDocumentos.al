page 50168 "Tipos de Documentos"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = tipoDocumentos;
    CardPageId = "Agregar Tipo Documento";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(DTE; Rec.DTE)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Número de documento tributario electrónico (DTE).';

                }

                field(Tipo; Rec.Tipo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Tipo de documento establecido por el SII.';
                    Caption = 'Tipo documento';
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
                        TipoDocumento: Record tipoDocumentos;
                        ReestablecerTabla: Codeunit InstalacionAplicacion;
                    begin
                        TipoDocumento.DeleteAll();
                        ReestablecerTabla.LlenadoDeTablaTipoDocumentos();
                        Message('Se ha reestablecido tabla correctamente');
                    end;
                }
            }
        }
    }
}