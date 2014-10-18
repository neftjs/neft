exports.createQmlObject = (type, id) ->
	Qt.createQmlObject "import QtQuick 2.3; #{type} {property string uid: \"#{id}\";}", stylesHatchery