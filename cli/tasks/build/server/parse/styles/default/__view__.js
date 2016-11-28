Column {
    if (Device.platform === 'iOS') {
        padding.top: 20
    }

    Flow {
        layout.fillWidth: true
        layout.fillHeight: true
        document.query: 'body'
    }
}
