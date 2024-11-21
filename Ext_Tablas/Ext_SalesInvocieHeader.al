tableextension 50102 ExtensionSalesInvocieHeader extends "Sales Invoice Header"
{
    fields
    {
        field(50704; codigoDocVenta; Integer)
        {
            Caption = 'Codigo Doc. Compra';
            DataClassification = ToBeClassified;
            TableRelation = DocumentoVentas;
        }

        field(50703; Folio; Integer)
        {
            Caption = 'Folio';
            DataClassification = ToBeClassified;
        }

        field(50181; Id_Transaccion; Code[60])
        {
            Caption = 'Id de transacción';
            DataClassification = ToBeClassified;
            TableRelation = tipoTransaccion;
        }

        field(50773; DTE; Code[60])
        {
            Caption = 'Tipo de Documento';
            DataClassification = ToBeClassified;
            TableRelation = tipoDocumentos;
        }

        field(50776; listFormaPago; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Forma de Pago';
            OptionMembers = ,Contado,Crédito,"Sin Costo (entrega gratuita)";

            trigger OnValidate()
            begin
                if listFormaPago = listFormaPago::Contado then
                    formaPago := 1
                else
                    if listFormaPago = listFormaPago::Crédito then
                        formaPago := 2
                    else
                        if listFormaPago = listFormaPago::"Sin Costo (entrega gratuita)" then
                            formaPago := 3
            end;
        }

        field(50777; formaPago; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Forma de Pago';
        }

        field(50778; Sucursal; Text[75])
        {
            Caption = 'Sucursal';
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(50779; Transportista; Code[60])
        {
            Caption = 'Forma de Entrega';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
        }

        field(50780; codigoActividad; Code[250])
        {
            Caption = 'Actividad Economica';
            DataClassification = ToBeClassified;
            TableRelation = actividadEconomica;
        }



        field(50782; patenteTransportista; Text[6])
        {
            Caption = 'Patente Transportista';
            DataClassification = ToBeClassified;
        }

        field(50783; RUT_Transportista; Integer)
        {
            Caption = 'RUT Transportista';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ValidarRUT: Codeunit ValidarDigitoVerificador;
            begin
                ValidarRUT.VerificarRUT(RUT_Transportista);
            end;
        }

        field(50784; DV; Code[1])
        {
            Caption = 'Dígito verificador';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ValidarRut: Codeunit ValidarDigitoVerificador;
            begin
                ValidarRut.ValidarDigitoVerificador(Rec.RUT_Transportista, DV);
            end;
        }

        field(50781; rutTransportista; Text[12])//--Obsoleto
        {
            Caption = 'Rut Transportista';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Problemas con el tipo de valor';
        }
        modify("Sell-to Customer Name")//--Cuando se haga un cambio dentro de una field (Sell-to Customer Name), se gatillará esta función para cambiar el valor de la actividad económica
        {
            trigger OnAfterValidate()
            var
                Cliente: Record Customer;
            begin
                Cliente.SetRange(Name, "Sell-to Customer Name");
                if Cliente.FindSet() then begin
                    Rec.codigoActividad := Cliente.codigo_Actividad;
                end;
            end;
        }
        field(50789; "envio/anulación"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50666; "Blob PDF"; blob)
        {
            Caption = 'PDF';
            DataClassification = ToBeClassified;
        }

    }
}