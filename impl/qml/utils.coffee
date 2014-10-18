exports.createQmlObject = (type, id) ->
	qmlStr = "import QtQuick 2.3; "
	qmlStr += "#{type} {"

	if id?
		qmlStr += "property string uid: \"#{id}\";"

	qmlStr += "}"

	Qt.createQmlObject qmlStr, stylesHatchery