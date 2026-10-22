import QtQuick
import QtQuick.Window

Image {
    id: symbol
    property var context: ({})
    readonly property string kind: context.id || ""
    readonly property var model: context.model || null
    readonly property bool muted: kind === "omarchy.audio" && model ? model.outputMuted : false
    readonly property bool bluetoothOn: kind === "omarchy.bluetooth" && model ? !!(model.adapter && model.adapter.enabled) : true
    readonly property bool wifi: kind === "omarchy.network" && model ? model.kind === "wifi" : false
    readonly property real volume: kind === "omarchy.audio" && model ? model.outputVolume : 1
    // Rasterise the vector directly onto the physical pixel grid. A 64px bitmap
    // minified into an 18px canvas loses the thin stems on a 1× display.
    sourceSize: Qt.size(Math.round(width * Screen.devicePixelRatio), Math.round(height * Screen.devicePixelRatio))
    smooth: false
    mipmap: false
    fillMode: Image.PreserveAspectFit
    source: "data:image/svg+xml;utf8," + encodeURIComponent(svg())

    function svg() {
        let art = "";
        if (kind === "omarchy.audio") {
            art = '<path d="M1.5 6.5h3L8 3.4v11.2l-3.5-3.1h-3Z" fill="currentColor" stroke="none"/>';
            if (muted) art += '<path d="m11 6.5 5 5m0-5-5 5"/>';
            else {
                if(volume>.01) art += '<path d="M10.5 6.5a4 4 0 0 1 0 5"/>';
                if(volume>.33) art += '<path d="M13 4.3a7 7 0 0 1 0 9.4"/>';
                if(volume>.66) art += '<path d="M15.4 2.2a10 10 0 0 1 0 13.6"/>';
            }
        } else if (kind === "omarchy.bluetooth") {
            art = '<path d="m5.5 5 7 7-3.5 3.5v-13L12.5 6l-7 7"/>';
        } else if (kind === "omarchy.network") {
            art = wifi ? '<path d="M1.5 5.8a12 12 0 0 1 15 0M4 8.7a8 8 0 0 1 10 0M6.6 11.6a4 4 0 0 1 4.8 0" stroke-width="1.8"/><circle cx="9" cy="14.5" r="1.2" fill="currentColor" stroke="none"/>'
              : '<rect x="2.5" y="3.5" width="13" height="9" rx="1"/><path d="M6 4v3m3-3v3m3-3v3M7 12.5v3h4v-3"/>';
        } else if (kind === "omarchy.monitor") {
            art = '<rect x="1.5" y="5.5" width="11" height="8" rx="1"/><path d="M5 16h4m-2-2.5V16M5.5 2.5h10a1 1 0 0 1 1 1v7"/>';
        } else if (kind === "omarchy.system-update") {
            art = '<path d="M14.4 6.5A5.6 5.6 0 0 0 4 5m-.4-2v3.5H7M3.6 11.5A5.6 5.6 0 0 0 14 13m.4 2v-3.5H11"/>';
        } else if (kind === "omarchy.agents") {
            art = '<rect x="3" y="5.5" width="12" height="9" rx="3"/><path d="M9 5.5V2.5M1 8v3m16-3v3M7 12h4"/><circle cx="6.5" cy="9" r=".8" fill="currentColor" stroke="none"/><circle cx="11.5" cy="9" r=".8" fill="currentColor" stroke="none"/>';
        }
        const color=bluetoothOn ? '#f5f5f7' : '#c4c4c8';
        return '<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18" color="'+color+'"><g fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round">'+art+'</g></svg>';
    }
}
