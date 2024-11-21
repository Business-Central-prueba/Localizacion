codeunit 50115 XMLTstingTipoDocumento
{
    procedure ImportarXMLDataTipoDocumento()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        TipoDocumento: Record tipoDocumentos;
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
            TipoDocumento.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'DTE':
                        TipoDocumento.Validate(TipoDocumento.DTE, Node2.AsXmlElement().InnerText);
                    'Tipo':
                        TipoDocumento.Validate(TipoDocumento.Tipo, Node2.AsXmlElement().InnerText);

                end;
            end;
            TipoDocumento.Insert(true);
        end;
    end;


    //--------------------------------------------Exportar XML
    procedure XMLExportarTipoDocumento()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        TipoDocumento: Record tipoDocumentos;
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
        TipoDocumento.FindSet();

        repeat

            ParentNode := XmlElement.Create('TipoDocumento');
            RootNode.add(ParentNode);
            FieldCaption := 'DTE';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(TipoDocumento.DTE);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'Tipo';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(TipoDocumento.Tipo);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

        until TipoDocumento.Next() = 0;

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        XMLDoc.WriteTo(Outstr);
        Outstr.WriteText(WriteTxt);
        Instr.ReadText(WriteTxt);
        ReadTxt := 'LocalizacionChile_TipoDocumento.XML';
        DownloadFromStream(Instr, '', '', '', ReadTxt);
        Message('Se ha descargado correctamente el XML de Tipo de documento.');

    end;
}