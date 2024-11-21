page 50166 "Bancos Chile"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Bancos;
    CardPageId = "Agregar Banco Chile";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(codigoBanco; Rec.codigoBanco)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Código de banco SBIF.';
                    Caption = 'Código SBIF';
                }

                field(nombreBanco; Rec.nombreBanco)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Nombre de banco.';
                    Caption = 'Nombre de banco';
                }

                field(opcionTipoBancos; Rec.Opcion_Tipo_Banco)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Código del tipo de banco.';
                    Caption = 'Tipo de banco';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemRec: Record tipoBanco;
                    begin
                        ItemRec.Reset();
                        if Page.RunModal(Page::"Tipos de Banco", ItemRec) = Action::LookupOK then
                            Rec.Opcion_Tipo_Banco := ItemRec.Codigo_Tipo_Banco;
                    end;
                }
            }
        }

    }

    actions
    {

        area(Processing)
        {

            group("Administración de tablas")
            {
                action("Reestablecer tabla por defecto")
                {
                    trigger OnAction()
                    var
                        Bancos: Record Bancos;
                        Reestablecer: Codeunit InstalacionAplicacion;
                    begin
                        Bancos.DeleteAll();
                        Reestablecer.LlenadoDeTablaBanco();
                        Message('Se ha reestablecido tabla con éxito');
                    end;
                }
            }
            group("Ver tablas relacionadas")
            {
                action("Ir a tabla Tipo de bancos")
                {
                    ApplicationArea = All;
                    RunObject = page "Tipos de Banco";
                }
            }
        }
    }
}