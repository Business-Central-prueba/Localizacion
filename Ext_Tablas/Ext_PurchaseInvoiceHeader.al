tableextension 50103 ExtensionPurchaseInvoiceHeader extends "Purch. Inv. Header"
{
    fields
    {

        field(50704; codigoDocVenta; Integer)
        {
            Caption = 'Codigo Doc. Compra';
            DataClassification = ToBeClassified;
            TableRelation = DocumentoVentas;
        }

        field(50770; Folio; Integer)
        {
            Caption = 'Localización Chile. Número de Folio';
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


        field(50774; listFormaPago; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Localización Chile. Forma de Pago';
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

        field(50775; formaPago; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Forma de Pago';
        }

        field(50776; Sucursal; Text[75])
        {
            Caption = 'Sucursal';
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(50781; Transportista; Code[60])
        {
            Caption = 'Forma de Entrega';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
        }

        field(50778; codigoActividad; Code[250])
        {
            Caption = 'Actividad Economica';
            DataClassification = ToBeClassified;
            TableRelation = actividadEconomica;
        }



        field(50780; patenteTransportista; Text[6])
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

        field(50782; DV; Code[1])
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

        field(50779; rutTransportista; Text[12])//--Obsoleto
        {
            Caption = 'Rut Transportista';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Problemas con el tipo de valor';
        }
        /*
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

        field(50790; "Blob PDF"; blob)
        {
            caption = 'PDF';
            DataClassification = CustomerContent;
        }

        field(50791; "Blob"; Blob)
        {
            Caption = 'blob';
            DataClassification = CustomerContent;
        }
        */

    }
}