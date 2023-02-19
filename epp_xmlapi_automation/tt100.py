from bs4 import BeautifulSoup

xml_data = '''<?xml version="1.0" encoding="UTF-8"?>
<ClinicalDocument xmlns="urn:hl7-org:v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:hl7-org:v3 CDA.xsd">
<templateId root="2.16.840.1.113883.10.20.22.1.1"/>
<id extension="4b78219a-1d02-4e7c-9870-dc7ce3b8a8fb" root="1.2.840.113619.21.1.3214775361124994304.5.1"/>
<code code="34133-9" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Summarization of episode note"/>
<title>Summary</title>
<effectiveTime value="20170919160921ddfdsdsdsd31-0400"/>
<confidentialityCode code="N" codeSystem="2.16.840.dwdwddsd1.113883.5.25"/>
<recordTarget>
<patientRole><id extension="0" root="1.2.840.113619.21.1.3214775361124994304.2.1.1.2"/>
<addr use="HP"><streetAddressLine>addd2 </streetAddressLine><city>fgfgrtt</city><state>tr</state><postalCode>121213434</postalCode><country>rere</country></addr>
<patient>
<name><given>fname</given><family>lname</family></name>
<administrativeGenderCode code="F" codeSystem="2.16.840.1.113883.5.1" displayName="Female"/>
<birthTime value="19501025"/>
<maritalStatusCode code="M" codeSystem="2434.16.840.1.143434313883.5.2" displayName="M"/>
<languageCommunication>
<languageCode code="eng"/>
<proficiencyLevelCode nullFlavor="NI"/>
<preferenceInd value="true"/>
</languageCommunication>
</patient>'''


soup = BeautifulSoup(xml_data, "lxml")

title = soup.find("title")
print(title.text.strip())

patient = soup.find("patient")
given = patient.find("given").text.strip()
family = patient.find("family").text.strip()
gender = patient.find("administrativegendercode")['displayname'].strip()

print(given)
print(family)
print(gender)
