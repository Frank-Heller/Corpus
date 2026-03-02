$filePath = "$pwd\..\Publications.xml"
$fileComment = @"
 
This file was generated $(Get-Date) by a script.
Do not change this file.
 
"@

[xml]$outxml = New-Object System.Xml.XmlDocument
$outxml.AppendChild($outxml.CreateXmlDeclaration("1.0","utf-8",$null)) | Out-Null
$outxml.AppendChild($outxml.CreateComment($fileComment)) | Out-Null

$root = $outxml.CreateNode("element","publications",$null) 

# iterate through all xml-files (except the file we are about to generate)
Get-ChildItem ../*.xml -exclude Publications.xml |		
	ForEach-Object {
		$pub = $outxml.CreateNode("element","publication",$null)

		[XML]$teiFile = Get-Content $_ -encoding utf8		

		# create the title and append to Publications.xml
		$titleElement = $outxml.CreateElement("title");
		$titleElement.InnerText = $teiFile.TEI.teiHeader.fileDesc.titleStmt.title;
		$pub.AppendChild($titleElement) | Out-Null;

		# create the idno and append to Publications.xml
		$idnoElement = $outxml.CreateElement("idno");
		$idnoElement.InnerText = $teiFile.TEI.teiHeader.fileDesc.publicationStmt.idno;
		$pub.AppendChild($idnoElement) | Out-Null;
		# 
		
		# get the relative filename
		$teiFileName = Resolve-path -path $_.FullName -Relative
		if ($teiFileName.StartsWith("..")) {
			$teiFileName = $teiFileName.SubString(3)
		}
		$filename = $outxml.CreateNode("element","filename",$null)
		$filename.InnerText = $teiFileName
		$pub.AppendChild($filename) | Out-Null

		# no "| Out-Null", log title and idno to screen
		$root.AppendChild($pub) 
	}
	
$outxml.AppendChild($root) | Out-Null

$outxml.save($filePath)


