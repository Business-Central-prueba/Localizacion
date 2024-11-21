tableextension 50127 "Folio Compra" extends "Purchase Header"
{
    fields
    {
        field(50704; codigoDocCompra; Integer)
        {
            Caption = 'Localización Chile. Codigo Doc. Compra';
            DataClassification = ToBeClassified;
            TableRelation = DocumentoCompras;
        }

        field(50770; Folio; Integer)
        {
            Caption = 'Localización Chile. Número de Folio';
            DataClassification = ToBeClassified;
        }

        field(50181; Id_Transaccion; Code[60])
        {
            Caption = 'Localización Chile. Tipo de transacción';
            DataClassification = ToBeClassified;
            TableRelation = tipoTransaccion;
        }
        field(50773; DTE; Code[60])
        {
            Caption = 'Localización Chile. Tipo de Documento';
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
            Caption = 'Localización Chile. Forma de Pago';
        }

        field(50776; Sucursal; Text[75])
        {
            Caption = 'Localización Chile. Sucursal';
            DataClassification = ToBeClassified;
        }

        field(50781; Transportistas; Code[60])
        {
            Caption = 'Localización Chile. Forma de Entrega';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
        }

        field(50778; codigoActividad; Code[200])
        {
            Caption = 'Localización Chile. Actividad Economica';
            DataClassification = ToBeClassified;
            TableRelation = actividadEconomica;
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

        field(50783; RUT_Transportista; Integer)
        {
            Caption = 'RUT transportista';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ValidarRUT: Codeunit ValidarDigitoVerificador;
            begin
                ValidarRUT.VerificarRUT(RUT_Transportista);
            end;
        }

        field(50780; patenteTransportista; Text[6])
        {
            Caption = 'Patente Transportista';
            DataClassification = ToBeClassified;
        }



        field(50777; Transportista; Code[10])//--------Obsoleto
        {
            Caption = 'Localización Chile. Forma de Entrega';
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
            ObsoleteState = Removed;
            ObsoleteReason = 'Largo insuficiente';
        }


        field(50779; rutTransportista; Text[12])//--Obsoleto
        {
            Caption = 'Rut Transportista';
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
            ObsoleteReason = 'Problemas con el tipo de valor';
        }


        modify("Buy-from Vendor Name")
        {
            trigger OnAfterValidate()
            var
                Proveedor: Record Vendor;
            begin
                Proveedor.SetRange(Name, "Buy-from Vendor Name");
                if Proveedor.FindSet() then begin
                    Rec.codigoActividad := Proveedor.codigoActividad;
                end;
            end;
        }

    }
}