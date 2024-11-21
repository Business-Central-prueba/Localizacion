codeunit 50105 XMLTsting
{
    procedure ImportarXMLData()
    var
        FromFile: Text;
        Instr: InStream;
        XmlDoc: XmlDocument;
        Tab: XmlElement;
        NodeList: XmlNodeList;
        NodeListSec: XmlNodeList;
        Node1: XmlNode;
        Node2: XmlNode;
        Customer: Record Customer;
        Element: XmlElement;
    begin
        if UploadIntoStream('Subir contenido XML', '', '', FromFile, Instr) then
            XmlDocument.ReadFrom(Instr, XmlDoc)
        else
            Error('No hay archivo XML o se ha cancelado la operación');

        if XmlDoc.GetRoot(Tab) then
            NodeList := Tab.GetChildElements();

        foreach Node1 in NodeList do begin
            Customer.Init();
            Element := Node1.AsXmlElement();
            NodeListSec := Element.GetChildElements();
            foreach Node2 in NodeListSec do begin
                case Node2.AsXmlElement().Name of
                    'No.':
                        Customer.Validate(Customer."No.", Node2.AsXmlElement().InnerText);
                    'Nombre':
                        Customer.Validate(Customer.Name, Node2.AsXmlElement().InnerText);
                    'Rut_Cliente':
                        Evaluate(Customer.Rut_Cliente, Node2.AsXmlElement().InnerText, 9);
                    'Facebook':
                        Customer.Validate(Customer.FacebookCliente, Node2.AsXmlElement().InnerText);
                    'LinkedIn':
                        Customer.Validate(Customer.Instagram, Node2.AsXmlElement().InnerText);
                    'Instagram':
                        Customer.Validate(Customer.Instagram, Node2.AsXmlElement().InnerText);
                    'Name2':
                        Customer.Validate(Customer."Name 2", Node2.AsXmlElement().InnerText);
                    'SearchName':
                        Customer.Validate(Customer."Search Name", Node2.AsXmlElement().InnerText);
                    'ICPartnerCode':
                        Customer.Validate(Customer."IC Partner Code", Node2.AsXmlElement().InnerText);
                    'BalanceLCY':
                        Evaluate(Customer."Balance (LCY)", Node2.AsXmlElement().InnerText, 9);
                    'CreditLimit':
                        Evaluate(Customer."Credit Limit (LCY)", Node2.AsXmlElement().InnerText, 9);
                    'SalesPersonCode':
                        Customer.Validate(Customer."Salesperson Code", Node2.AsXmlElement().InnerText);
                    'ResponsibilityCenter':
                        Customer.Validate(Customer."Responsibility Center", Node2.AsXmlElement().InnerText);
                    'ServiceZoneCode':
                        Customer.Validate(Customer."Service Zone Code", Node2.AsXmlElement().InnerText);
                    'DocumentSendingProfile':
                        Customer.Validate(Customer."Document Sending Profile", Node2.AsXmlElement().InnerText);


                    //----------------------------Seccion direccion 

                    'Address':
                        Customer.Validate(Customer.Address, Node2.AsXmlElement().InnerText);
                    'Adress2':
                        Customer.Validate(Customer."Address 2", Node2.AsXmlElement().InnerText);
                    'CountryRegionCode':
                        Customer.Validate(Customer."Country/Region Code", Node2.AsXmlElement().InnerText);
                    'City':
                        Customer.Validate(Customer.City, Node2.AsXmlElement().InnerText);
                    'PostCode':
                        Customer.Validate(Customer."Post Code", Node2.AsXmlElement().InnerText);
                    'PhoneNo':
                        Customer.Validate(Customer."Phone No.", Node2.AsXmlElement().InnerText);
                    'MobilePhoneNo':
                        Customer.Validate(Customer."Mobile Phone No.", Node2.AsXmlElement().InnerText);
                    'EMail':
                        Customer.Validate(Customer."E-Mail", Node2.AsXmlElement().InnerText);
                    'FaxNo':
                        Customer.Validate(Customer."Fax No.", Node2.AsXmlElement().InnerText);
                    'HomePage':
                        Customer.Validate(Customer."Home Page", Node2.AsXmlElement().InnerText);
                    'LanguajeCode':
                        Customer.Validate(Customer."Language Code", Node2.AsXmlElement().InnerText);
                    //'Contact':
                    //  Customer.Validate(Customer.Contact, Node2.AsXmlElement().InnerText);
                    'Billtocustomerno':
                        Customer.Validate(Customer."Bill-to Customer No.", Node2.AsXmlElement().InnerText);
                    'VATregistrationNo':
                        Customer.Validate(Customer."VAT Registration No.", Node2.AsXmlElement().InnerText);
                    'EORINumber':
                        Customer.Validate(Customer."EORI Number", Node2.AsXmlElement().InnerText);
                    'GLN':
                        Customer.Validate(Customer.GLN, Node2.AsXmlElement().InnerText);
                    // 'UseGLNinElectricDocument':
                    //   Evaluate(Customer."Use GLN in Electronic Document", Node2.AsXmlElement().InnerText, 9);
                    //'CopySelltoAddrtoqtefrom':
                    //  Evaluate(Customer."Copy Sell-to Addr. to Qte From", Node2.AsXmlElement().InnerText, 9);
                    'TaxAreaCode':
                        Customer.Validate(Customer."Tax Area Code", Node2.AsXmlElement().InnerText);

                    //-------------------------Seccion posting details

                    'genbuspostinggroup':
                        Customer.Validate(Customer."Gen. Bus. Posting Group", Node2.AsXmlElement().InnerText);
                    'vatbus':
                        Customer.Validate(Customer."VAT Bus. Posting Group", Node2.AsXmlElement().InnerText);
                    'customerpostinggroup':
                        Customer.Validate(Customer."Customer Posting Group", Node2.AsXmlElement().InnerText);

                    //--------------------------Seccion price and discounts

                    'CurrencyCode':
                        Customer.Validate(Customer."Currency Code", Node2.AsXmlElement().InnerText);
                    //'pricecalculationmethod':
                    //  Evaluate(Customer."Price Calculation Method", Node2.AsXmlElement().InnerText, 9);
                    'Customerpricegroup':
                        Customer.Validate(Customer."Customer Price Group", Node2.AsXmlElement().InnerText);
                    'customerdiscgroup':
                        Customer.Validate(Customer."Customer Disc. Group", Node2.AsXmlElement().InnerText);
                    // 'allowlinedisc':
                    //   Evaluate(Customer."Allow Line Disc.", Node2.AsXmlElement().InnerText, 9);
                    'invoicedisccode':
                        Customer.Validate(Customer."Invoice Disc. Code", Node2.AsXmlElement().InnerText);
                    //-----------------------------Seccion de payments

                    'Prepaymentpor':
                        Evaluate(Customer."Prepayment %", Node2.AsXmlElement().InnerText, 9);
                    //'applicationmethod':
                    //  Evaluate(Customer."Application Method", Node2.AsXmlElement().InnerText, 9);
                    'partnertype':
                        Customer.Validate(Customer."Customer Posting Group", Node2.AsXmlElement().InnerText);
                    //  'instrstattype':
                    //    Evaluate(Customer."Intrastat Partner Type", Node2.AsXmlElement().InnerText, 9);
                    'paymentstermscode':
                        Customer.Validate(Customer."Payment Terms Code", Node2.AsXmlElement().InnerText);
                    'paymentmethodcode':
                        Customer.Validate(Customer."Payment Method Code", Node2.AsXmlElement().InnerText);
                    /*'paymentdayscode':
                        Customer.Validate(Customer."Payment Days Code", Node2.AsXmlElement().InnerText);
                    'nonpaymentperiodscode':
                        Customer.Validate(Customer."Non-Paymt. Periods Code", Node2.AsXmlElement().InnerText);*/
                    'ReminderTermscode':
                        Customer.Validate(Customer."Reminder Terms Code", Node2.AsXmlElement().InnerText);
                    'finchargetermscode':
                        Customer.Validate(Customer."Fin. Charge Terms Code", Node2.AsXmlElement().InnerText);
                    'cashflowpaymenttermscode':
                        Customer.Validate(Customer."Cash Flow Payment Terms Code", Node2.AsXmlElement().InnerText);
                    'LastStatements':
                        Evaluate(Customer."Last Statement No.", Node2.AsXmlElement().InnerText, 9);
                    'preferredbankaccountcode':
                        Customer.Validate(Customer."Preferred Bank Account Code", Node2.AsXmlElement().InnerText);

                    //-------------------------Seccion de shipping

                    'shiptocode':
                        Customer.Validate(Customer."Ship-to Code", Node2.AsXmlElement().InnerText);
                    'locationcode':
                        Customer.Validate(Customer."Location Code", Node2.AsXmlElement().InnerText);
                    // 'Combineshipments':
                    //   Evaluate(Customer."Combine Shipments", Node2.AsXmlElement().InnerText, 9);
                    // 'Reserve':
                    //   Evaluate(Customer.Reserve, Node2.AsXmlElement().InnerText, 9);
                    //'ShipingAdvice':
                    //  Evaluate(Customer."Shipping Advice", Node2.AsXmlElement().InnerText, 9);

                    //---------------------Seccion de shipment method

                    'shipmentmethodcode':
                        Customer.Validate(Customer."Shipment Method Code", Node2.AsXmlElement().InnerText);
                    'shippingagentcode':
                        Customer.Validate(Customer."Shipping Agent Code", Node2.AsXmlElement().InnerText);
                    'shippingangentservicecode':
                        Customer.Validate(Customer."Shipping Agent Service Code", Node2.AsXmlElement().InnerText);
                    //'shippintime':
                    //  Evaluate(Customer."Shipping Time", Node2.AsXmlElement().InnerText, 9);
                    'basecalendarcode':
                        Customer.Validate(Customer."Base Calendar Code", Node2.AsXmlElement().InnerText);
                end;
            end;


            Customer.Insert(true);
        end;
    end;

    //---------------------------------Exportar el XML
    procedure XMLExportar()
    var
        XMLDoc: XmlDocument;
        XMLDec: XmlDeclaration;
        RootNode: XmlElement;
        Cust: Record Customer;
        Proveedor: Record Vendor;
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
        //XMLDec := XmlDeclaration.Create('1.0', 'UTF-8', '');
        //XmlDoc.SetDeclaration(XMLDec);
        RootNode := XmlElement.Create('Table');
        XMLDoc.Add(RootNode);
        Cust.FindSet();

        repeat

            ParentNode := XmlElement.Create('Customer');
            RootNode.add(ParentNode);



            FieldCaption := 'No.';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Cust."No.");
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Nombre';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Cust.Name);
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Rut_Cliente';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust.Rut_Cliente));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'Facebook';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust.FacebookCliente));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'LinkedIn';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust.LinkedIn));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'Instagram';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust.Instagram));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Name2';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Name 2"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'SearchName';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Search Name"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'ICPartnerCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."IC Partner Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'BalanceLCY';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Balance (LCY)"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'CreditLimit';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Credit Limit (LCY)"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Blocked';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust.Blocked));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'SalesPersonCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Salesperson Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'ResponsibilityCenter';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Responsibility Center"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            FieldCaption := 'ServiceZoneCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Service Zone Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'DocumentSendingProfile';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Document Sending Profile"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'LastDateModified';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Last Date Modified"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            //---------------------------------------------Sección de dirección y contacto

            FieldCaption := 'Address';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust.Address));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Adress2';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Address 2"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'CountryRegionCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Country/Region Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'City';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust.City));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'PostCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Post Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'PhoneNo';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Phone No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'MobilePhoneNo';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Mobile Phone No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'EMail';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."E-Mail"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'FaxNo';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Fax No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'HomePage';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Home Page"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'LanguajeCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Language Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Contact';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust.Contact));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'Billtocustomerno';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Bill-to Customer No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'VATregistrationNo';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."VAT Registration No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'EORINumber';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."EORI Number"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'GLN';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust.GLN));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /*FieldCaption := 'UseGLNinElectricDocument';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Use GLN in Electronic Document"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'CopySelltoAddrtoqtefrom';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Copy Sell-to Addr. to Qte From"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

             FieldCaption := 'Taxliable';
             ChildNode := XmlElement.Create(FieldCaption);
             XMLTxt := XmlText.Create(Format(Cust."Tax Liable"));
             ChildNode.add(XMLTxt);
             ParentNode.add(ChildNode);
 */
            FieldCaption := 'TaxAreaCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Tax Area Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            //----------------------------Seccion posting details

            FieldCaption := 'genbuspostinggroup';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Gen. Bus. Posting Group"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'vatbus';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."VAT Bus. Posting Group"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'customerpostinggroup';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Customer Posting Group"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);


            //----------------------Seccion price and discounts

            FieldCaption := 'CurrencyCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Currency Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /*FieldCaption := 'pricecalculationmethod';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Price Calculation Method"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);*/

            FieldCaption := 'Customerpricegroup';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Customer Price Group"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'customerdiscgroup';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Customer Disc. Group"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /* FieldCaption := 'allowlinedisc';
             ChildNode := XmlElement.Create(FieldCaption);
             XMLTxt := XmlText.Create(Format(Cust."Allow Line Disc."));
             ChildNode.add(XMLTxt);
             ParentNode.add(ChildNode);*/

            FieldCaption := 'invoicedisccode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Invoice Disc. Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /* FieldCaption := 'pricesincludingvat';
             ChildNode := XmlElement.Create(FieldCaption);
             XMLTxt := XmlText.Create(Format(Cust."Prices Including VAT"));
             ChildNode.add(XMLTxt);
             ParentNode.add(ChildNode);*/



            //----------------------------------------------------Seccion de payments

            FieldCaption := 'Prepaymentpor';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Prepayment %"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /*FieldCaption := 'applicationmethod';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Application Method"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);*/

            FieldCaption := 'partnertype';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Partner Type"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /*FieldCaption := 'instrstattype';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Intrastat Partner Type"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);*/

            FieldCaption := 'paymentstermscode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Payment Terms Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'paymentmethodcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Payment Method Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /*
            
            FieldCaption := 'paymentdayscode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Payment Days Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'nonpaymentperiodscode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Non-Paymt. Periods Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            */

            FieldCaption := 'ReminderTermscode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Reminder Terms Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'finchargetermscode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Fin. Charge Terms Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'cashflowpaymenttermscode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Cash Flow Payment Terms Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /* FieldCaption := 'printstatements';
             ChildNode := XmlElement.Create(FieldCaption);
             XMLTxt := XmlText.Create(Format(Cust."Print Statements"));
             ChildNode.add(XMLTxt);
             ParentNode.add(ChildNode);*/

            FieldCaption := 'LastStatements';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Last Statement No."));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /*FieldCaption := 'blockpaymenttolerance';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Block Payment Tolerance"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);*/

            FieldCaption := 'preferredbankaccountcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Preferred Bank Account Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            //-----------------------------------------Sección de shipping

            FieldCaption := 'shiptocode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Ship-to Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'locationcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Location Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /* FieldCaption := 'Combineshipments';
             ChildNode := XmlElement.Create(FieldCaption);
             XMLTxt := XmlText.Create(Format(Cust."Combine Shipments"));
             ChildNode.add(XMLTxt);
             ParentNode.add(ChildNode);*/

            FieldCaption := 'CurrencyCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Currency Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /*FieldCaption := 'Reserve';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust.Reserve));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);*/

            FieldCaption := 'CurrencyCode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Currency Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'ShipingAdvice';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Shipping Advice"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            //--------------------------------------------Seccion shipment method

            FieldCaption := 'shipmentmethodcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Shipment Method Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'shippingagentcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Shipping Agent Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            FieldCaption := 'shippingangentservicecode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Shipping Agent Service Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

            /*FieldCaption := 'shippintime';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Shipping Time"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);*/

            FieldCaption := 'basecalendarcode';
            ChildNode := XmlElement.Create(FieldCaption);
            XMLTxt := XmlText.Create(Format(Cust."Base Calendar Code"));
            ChildNode.add(XMLTxt);
            ParentNode.add(ChildNode);

        until Cust.Next() = 0;

        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        XMLDoc.WriteTo(Outstr);
        Outstr.WriteText(WriteTxt);
        Instr.ReadText(WriteTxt);
        ReadTxt := 'LocalizacionChile_Customer.XML';
        DownloadFromStream(Instr, '', '', '', ReadTxt);
        Message('Se ha descargado correctamente el XML de Clientes.');
    end;
}