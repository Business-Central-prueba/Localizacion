codeunit 50116 XMLTstingTipoTransaccion
{
    procedure ImportarXMLDataTipoTransaccion()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        TipoTransaccion: Record tipoTransaccion;
        Element: XmlElement;
        b: Integer;
    begin
        if UploadIntoStream('Subir contenido XML', '', '', FromFile, Instr) then
            XmlDocument.ReadFrom(Instr, XmlDoc)
        else
            Error('No hay archivo XML o se ha cancelado la operación');

        if XmlDoc.GetRoot(Tab) then
            NodeList := Tab.GetChildElements();

        foreach Node1 in NodeList do begin
            TipoTransaccion.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'DTE':
                        TipoTransaccion.Validate(TipoTransaccion.Id_Transaccion, Node2.AsXmlElement().InnerText);
                    'Tipo':
                        TipoTransaccion.Validate(TipoTransaccion.descripcionTransaccion, Node2.AsXmlElement().InnerText);
                end;
            end;
            TipoTransaccion.Insert(true);
        end;
    end;


    //--------------------------------------------------Exportar XML
    procedure XMLExportarTipoTransaccion()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        TipoTransaccion: Record tipoTransaccion;
        ParentNode: XmlElement;
        FieldCaption: Text;
        XMLTxt: XmlText;
        ChildNode: XmlElement;
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        Outstr: OutStream;
        ReadTxt: Text;
        WriteTxt: Text;
    begin
        XMLDoc := XmlDocument.Create();
        XMLDec := XmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XMLDec);
        RootNode := XmlElement.Create('Table');
        XMLDoc.Add(RootNode);
        TipoTransaccion.FindSet();

        repeat

            ParentNode := XmlElement.Create('TipoTransaccion');
            RootNode.add(ParentNode);
            FieldCaption := 'DTE';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(format(TipoTransaccion.Id_Transaccion));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Tipo';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(TipoTransaccion.descripcionTransaccion);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

        until TipoTransaccion.Next() = 0;

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        XMLDoc.WriteTo(Outstr);
        Outstr.WriteText(WriteTxt);
        Instr.ReadText(WriteTxt);
        ReadTxt := 'LocalizacionChile_TipoTransaccion.XML';
        DownloadFromStream(Instr, '', '', '', ReadTxt);
        Message('Se ha descargado correctamente el XML de Tipo transacción.');

    end;

}