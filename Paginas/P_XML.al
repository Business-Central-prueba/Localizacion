page 50147 "Carga de contenido XML"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Opci;
    MultipleNewLines = false;

    layout
    {
        area(Content)
        {
            repeater("Seleccionar tabla")
            {
                field(Opciones; Rec.Opciones)
                {
                    ApplicationArea = All;
                    ToolTip = 'Localización Chilena. Escoger tabla para realizar acción (Exportar o importar datos).';
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {

            group("Importar/Exportar XML")
            {
                action(Import)
                {
                    ApplicationArea = All;
                    Caption = 'Importar XML';
                    trigger OnAction()
                    var
                        ImportarCliente: Codeunit XMLTsting;
                        ImportarProveedor: Codeunit XMLTstingProveedor;
                        ImportarActividadEconomica: Codeunit XMLTstingActividadEconomica;
                        ImportarCategoriaActEconomica: Codeunit XMLTstingCategoriaActividad;
                        ImportarSubcategoriaEconomica: Codeunit XMLTstingSubCategoriaEconomica;
                        ImportarBanco: Codeunit XMLTstingBanco;
                        ImportarTipoBanco: Codeunit XMLTstingTipoBanco;
                        ImportarTipoTransaccion: Codeunit XMLTstingTipoTransaccion;
                        ImportarTipoDocumento: Codeunit XMLTstingTipoDocumento;
                        ImpotarCodigoPostal: Codeunit XMLTstingCodigoPostal;
                        ImportarEmpleado: Codeunit XMLTstingEmpleado;

                    begin
                        if (Rec.ValorSeleccionado = 1) then
                            ImportarCliente.ImportarXMLData();
                        if (Rec.ValorSeleccionado = 2) then
                            ImportarProveedor.ImportarXMLDataProveedor();
                        if (Rec.ValorSeleccionado = 3) then
                            ImportarCategoriaActEconomica.ImportarXMLDataCategoriaActividad();
                        if (Rec.ValorSeleccionado = 4) then
                            ImportarSubcategoriaEconomica.ImportarXMLDataSubCategoriaEconomica();
                        if (Rec.ValorSeleccionado = 5) then
                            ImportarActividadEconomica.ImportarXMLDataActividadEconomica();
                        if (Rec.ValorSeleccionado = 6) then
                            ImportarBanco.ImportarXMLDataBanco();
                        if (Rec.ValorSeleccionado = 7) then
                            ImportarTipoBanco.ImportarXMLDataTipoBanco();
                        if (Rec.ValorSeleccionado = 8) then
                            ImportarTipoDocumento.ImportarXMLDataTipoDocumento();
                        if (Rec.ValorSeleccionado = 9) then
                            ImportarTipoTransaccion.ImportarXMLDataTipoTransaccion();
                        if (Rec.ValorSeleccionado = 10) then
                            ImpotarCodigoPostal.ImportarXMLDataCodigoPostal();
                        if (Rec.ValorSeleccionado = 11) then
                            ImportarEmpleado.ImportarXMLDataEmpleado();
                    end;
                }
                action(Export)
                {
                    ApplicationArea = All;
                    Caption = 'Exportar XML';
                    trigger OnAction()
                    var
                        ExportarCliente: Codeunit XMLTsting;
                        ExportarProveedor: Codeunit XMLTstingProveedor;
                        ExportarActividadEconomica: Codeunit XMLTstingActividadEconomica;
                        ExportarCategoriaeconomica: Codeunit XMLTstingCategoriaActividad;
                        ExportarSubCategoria: Codeunit XMLTstingSubCategoriaEconomica;
                        ExportarCodigoPostal: Codeunit XMLTstingCodigoPostal;
                        ExportarBanco: Codeunit XMLTstingBanco;
                        ExportarTipoBanco: Codeunit XMLTstingTipoBanco;
                        ExportarTipoDocumento: Codeunit XMLTstingTipoDocumento;
                        ExportarTipoTransaccion: Codeunit XMLTstingTipoTransaccion;
                        ExportarEmpleado: Codeunit XMLTstingEmpleado;
                    begin
                        if (Rec.ValorSeleccionado = 1) then
                            ExportarCliente.XMLExportar();
                        if (Rec.ValorSeleccionado = 2) then
                            ExportarProveedor.XMLExportarProveedor();
                        if (Rec.ValorSeleccionado = 3) then
                            ExportarCategoriaeconomica.XMLExportarCategoriaEconomica();
                        if (Rec.ValorSeleccionado = 4) then
                            ExportarSubCategoria.XMLExportarSubCategoriaEconomica();
                        if (Rec.ValorSeleccionado = 5) then
                            ExportarActividadEconomica.XMLExportarActividadesEconomicas();
                        if (Rec.ValorSeleccionado = 10) then
                            ExportarCodigoPostal.XMLExportarCodPostal();
                        if (Rec.ValorSeleccionado = 6) then
                            ExportarBanco.XMLExportarBanco();
                        if (Rec.ValorSeleccionado = 7) then
                            ExportarTipoBanco.XMLExportarTipoBanco();
                        if (Rec.ValorSeleccionado = 8) then
                            ExportarTipoDocumento.XMLExportarTipoDocumento();
                        if (Rec.ValorSeleccionado = 9) then
                            ExportarTipoTransaccion.XMLExportarTipoTransaccion();
                        if (Rec.ValorSeleccionado = 11) then
                            ExportarEmpleado.XMLExportarEmpleado();
                    end;
                }
            }

            group("Ver tablas")
            {
                group("Relacionado a Bancos")
                {
                    action("Ver tabla de Bancos Chile")
                    {
                        ApplicationArea = All;
                        RunObject = page "Bancos Chile";
                    }

                    action("Ver tabla de tipo de Bancos Chile")
                    {
                        ApplicationArea = All;
                        RunObject = page "Tipos de Banco";
                    }
                }

                group("Relacionado a tipo de documentos")
                {
                    action("Ver tabla tipo de documentos")
                    {
                        ApplicationArea = All;
                        RunObject = page "Tipos de Documentos";
                    }

                }

                group("Relacionado a tipo de transacciones")
                {
                    action("Ver tabla de tipo de transacciones")
                    {
                        ApplicationArea = All;
                        RunObject = page "Tipos de Transacciones";
                    }
                }

                group("Relacionado a tipo de actividades económicas")
                {
                    action("Ver tabla de categorías actividad económicas")
                    {
                        ApplicationArea = All;
                        RunObject = page "Categorias Act. Económicas";
                    }
                    action("Ver tabla de subcategorías actividades económicas")
                    {
                        ApplicationArea = All;
                        RunObject = page "Subcategoría act. económicas";
                    }

                    action("Ver tabla de actividades económicas")
                    {
                        ApplicationArea = All;
                        RunObject = page "Actividades Económicas";
                    }
                }

                group("Relacionado a clientes, empresas, etc.")
                {

                    action("Ver tabla de clientes")
                    {
                        ApplicationArea = All;
                        RunObject = page "Customer List";
                    }

                    action("Ver tabla de proveedores")
                    {
                        ApplicationArea = All;
                        RunObject = page "Vendor List";
                    }

                    action("Ver tabla de empleados")
                    {
                        ApplicationArea = All;
                        RunObject = page "Employee List";
                    }

                }
                group("Relacionado a ubicaciones")
                {
                    action("Ver tabla códigos postales")
                    {
                        ApplicationArea = All;
                        RunObject = page "Post Codes";
                    }
                }

            }

        }
    }
}

