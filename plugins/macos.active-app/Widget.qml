import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Ui
BarWidget {
 id: root
 moduleName: "macos.active-app"
 readonly property var active: ToplevelManager.activeToplevel
 readonly property var entry: active ? DesktopEntries.applications.values.find(e => (e.startupClass && e.startupClass.toLowerCase() === active.appId.toLowerCase()) || e.id.toLowerCase() === active.appId.toLowerCase()) : null
 readonly property string appName: entry ? entry.name : (active ? active.appId : "Masaüstü")
 implicitWidth: Math.min(190, label.implicitWidth) + 16
 implicitHeight: barSize
 Text { id:label; x:8; width:Math.min(190,implicitWidth); anchors.verticalCenter:parent.verticalCenter; text:root.appName; elide:Text.ElideRight; color:"#f5f5f7"; font.family:"Inter"; font.pixelSize:13; font.weight:Font.DemiBold }
 MouseArea { anchors.fill:parent; hoverEnabled:true; onClicked:if(root.active)root.active.activate(); onEntered:if(root.bar)root.bar.showTooltip(root,root.active ? root.active.title : root.appName); onExited:if(root.bar)root.bar.hideTooltip(root) }
}
