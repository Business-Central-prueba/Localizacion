
pageextension 50134 "extend purchase invoice posted" extends "Posted Purchase Invoice"
{
    layout
    {
        modify(Cancelled)
        {
            Visible = true;
        }
        addfirst(General)
        {
            field(Folio; Rec.Folio)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Número de folio de venta';
                Caption = 'N° Folio';
                Editable = true; // Campo solo de visualización
            }

            field(codigoActividad; Rec.codigoActividad)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Actividad económica';
                Caption = 'Actividad económica';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record actividadEconomica;
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Actividades Económicas", ItemRec) = Action::LookupOK then
                        Rec.codigoActividad := ItemRec.nombre_Actividad;
                end;
            }

            field(listFormaPago; Rec.listFormaPago)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Lista de forma de pago';
                Caption = 'Forma de pago';
            }

            field(Id_Transaccion; Rec.Id_Transaccion)
            {
                ApplicationArea = All;
                Caption = 'Tipo de transacción';
                ToolTip = 'Localización Chilena. Tipo de transacción';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record tipoTransaccion;
                    id: Text[30];
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Tipos de Transacciones", ItemRec) = Action::LookupOK then
                        Rec.Id_Transaccion := ItemRec.descripcionTransaccion;
                end;
            }

            field(DTE; Rec.DTE)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Documento Tributario Electrónico';
                Caption = 'DTE';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record tipoDocumentos;
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Tipos de Documentos", ItemRec) = Action::LookupOK then
                        Rec.DTE := ItemRec.Tipo;
                end;
            }
        }


        addlast(General)
        {
            field(Transportista; Rec.Transportista)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Transportista';
                Caption = 'Escoger Transportista';
                trigger OnLookup(var Text: Text): Boolean
                var
                    ItemRec: Record "Shipping Agent";
                begin
                    ItemRec.Reset();
                    if Page.RunModal(Page::"Shipping Agents", ItemRec) = Action::LookupOK then
                        Rec.Transportista := ItemRec.Name;
                end;
            }

            field(rutTransportista; Rec.RUT_Transportista)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. RUT del transportista';
                Caption = 'RUT Transportista';
            }

            field(DV; Rec.DV)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Dígito verificador del RUT del transportista';
            }

            field(patenteTransportista; Rec.patenteTransportista)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Patente del transportista';
                Caption = 'Patente transportista';
            }

            field(Sucursal; Rec.Sucursal)
            {
                ApplicationArea = All;
                ToolTip = 'Localización Chilena. Sucursal';
                Caption = 'Sucursal';
            }

        }



    }
}

