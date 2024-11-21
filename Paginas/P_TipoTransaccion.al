page 50167 "Tipos de Transacciones"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = tipoTransaccion;
    CardPageId = "Agregar Tipo Transaccion";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(idTransaccion; Rec.Id_Transaccion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Código del tipo de transacción.';

                }

                field(descripcionTransaccion; Rec.descripcionTransaccion)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Nombre de transacciones.';
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
                        TipoTransaccion: Record tipoTransaccion;
                        ReestablecerTabla: Codeunit InstalacionAplicacion;
                    begin
                        TipoTransaccion.DeleteAll();
                        ReestablecerTabla.LlenadoDeTablaTipoTransaccion();
                        Message('Se ha reestablecido tabla correctamente');
                    end;
                }
            }
        }
    }
}