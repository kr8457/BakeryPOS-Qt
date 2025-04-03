import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15

ApplicationWindow {
    id: window
    visible: true
    width: 1280
    height: 800
    title: "Modern Bakery POS"

    // Enable Material theme
    Material.theme: Material.Light
    Material.accent: Material.Orange
    Material.primary: Material.DeepOrange

    // Models
    ListModel {
        id: cartModel
        property real total: 0

        onCountChanged: {
            total = 0
            for (var i = 0; i < count; i++) {
                total += get(i).price * get(i).quantity
            }
        }
    }

    ListModel {
        id: productsModel
        ListElement {
            name: "Classic Cake";
            price: 500;
            category: "Cakes";
            image: "cake.png";
            description: "Fresh cream vanilla cake"
        }
        ListElement {
            name: "Chocolate Pastry";
            price: 150;
            category: "Pastries";
            image: "pastry.png";
            description: "Rich chocolate pastry"
        }
        // Add more products...
    }

    // Main ColumnLayout
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Top AppBar
        ToolBar {
            Layout.fillWidth: true
            Material.foreground: "white"
            RowLayout {
                anchors.fill: parent
                ToolButton {
                    text: qsTr("☰")
                    font.pointSize: 16
                    onClicked: drawer.open()
                }
                Label {
                    text: "Sweet Delights Bakery"
                    font.pointSize: 16
                    font.bold: true
                    elide: Label.ElideRight
                    horizontalAlignment: Qt.AlignHCenter
                    verticalAlignment: Qt.AlignVCenter
                    Layout.fillWidth: true
                }
                ToolButton {
                    text: qsTr("⚙")
                    font.pointSize: 16
                }
            }
        }

        // Content Area
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            // Products Section
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.margins: 16
                spacing: 16

                // Search and Filter
                RowLayout {
                    Layout.fillWidth: true
                    TextField {
                        Layout.fillWidth: true
                        placeholderText: "Search products..."
                        leftPadding: 40
                        Material.elevation: 1

                        Image {
                            source: "search.png"
                            width: 20
                            height: 20
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    ComboBox {
                        model: ["All Categories", "Cakes", "Pastries", "Breads", "Cookies"]
                        Layout.preferredWidth: 150
                    }
                }

                // Products Grid
                GridView {
                    id: productsGrid
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cellWidth: 200
                    cellHeight: 250
                    model: productsModel
                    clip: true

                    delegate: ItemDelegate {
                        width: productsGrid.cellWidth - 10
                        height: productsGrid.cellHeight - 10

                        Rectangle {
                            anchors.fill: parent
                            color: "white"
                            radius: 8
                            Material.elevation: 2

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 12
                                spacing: 8

                                Image {
                                    source: image
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 120
                                    fillMode: Image.PreserveAspectFit
                                }

                                Label {
                                    text: name
                                    font.bold: true
                                    Layout.fillWidth: true
                                }

                                Label {
                                    text: description
                                    color: Material.color(Material.Grey)
                                    Layout.fillWidth: true
                                    wrapMode: Text.WordWrap
                                }

                                RowLayout {
                                    Layout.fillWidth: true
                                    Label {
                                        text: "Rs. " + price
                                        font.bold: true
                                    }
                                    Item { Layout.fillWidth: true }
                                    Button {
                                        text: "Add"
                                        highlighted: true
                                        onClicked: {
                                            cartModel.append({
                                                "name": name,
                                                "price": price,
                                                "quantity": 1
                                            })
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Cart Section
            Pane {
                Layout.preferredWidth: 400
                Layout.fillHeight: true
                Material.elevation: 4

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 16

                    Label {
                        text: "Current Order"
                        font.bold: true
                        font.pointSize: 16
                    }

                    ListView {
                        id: cartList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: cartModel
                        spacing: 8
                        clip: true

                        delegate: ItemDelegate {
                            width: parent.width
                            height: 80

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 16

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Label {
                                        text: name
                                        font.bold: true
                                    }
                                    Label {
                                        text: "Rs. " + (price * quantity)
                                        color: Material.color(Material.Grey)
                                    }
                                }

                                SpinBox {
                                    value: quantity
                                    from: 1
                                    to: 99
                                    onValueChanged: {
                                        cartModel.setProperty(index, "quantity", value)
                                    }
                                }

                                ToolButton {
                                    text: "✕"
                                    onClicked: cartModel.remove(index)
                                }
                            }
                        }
                    }

                    // Order Summary
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: Material.color(Material.Grey)
                        opacity: 0.3
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        RowLayout {
                            Layout.fillWidth: true
                            Label { text: "Subtotal" }
                            Item { Layout.fillWidth: true }
                            Label { text: "Rs. " + cartModel.total }
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            Label { text: "Tax (13%)" }
                            Item { Layout.fillWidth: true }
                            Label { text: "Rs. " + (cartModel.total * 0.13).toFixed(2) }
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            Label {
                                text: "Total"
                                font.bold: true
                            }
                            Item { Layout.fillWidth: true }
                            Label {
                                text: "Rs. " + (cartModel.total * 1.13).toFixed(2)
                                font.bold: true
                            }
                        }
                    }

                    Button {
                        text: "Proceed to Checkout"
                        Layout.fillWidth: true
                        highlighted: true
                        enabled: cartModel.count > 0
                        onClicked: checkoutDialog.open()
                    }
                }
            }
        }
    }

    // Navigation Drawer
    Drawer {
        id: drawer
        width: Math.min(window.width * 0.3, 300)
        height: window.height

        Column {
            anchors.fill: parent
            spacing: 0

            ItemDelegate {
                width: parent.width
                text: "Dashboard"
                icon.source: "dashboard.png"
            }

            ItemDelegate {
                width: parent.width
                text: "Orders"
                icon.source: "orders.png"
            }

            ItemDelegate {
                width: parent.width
                text: "Products"
                icon.source: "products.png"
            }

            ItemDelegate {
                width: parent.width
                text: "Reports"
                icon.source: "reports.png"
            }

            ItemDelegate {
                width: parent.width
                text: "Settings"
                icon.source: "settings.png"
            }
        }
    }

    // Checkout Dialog
    Dialog {
        id: checkoutDialog
        title: "Checkout"
        width: 400
        x: (window.width - width) / 2
        y: (window.height - height) / 2
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            spacing: 20
            anchors.fill: parent

            ComboBox {
                Layout.fillWidth: true
                model: ["Cash", "Card", "UPI"]
                currentIndex: 0
            }

            TextField {
                Layout.fillWidth: true
                placeholderText: "Customer Name (optional)"
            }

            TextField {
                Layout.fillWidth: true
                placeholderText: "Customer Phone (optional)"
            }
        }

        onAccepted: {
            // Process payment and clear cart
            cartModel.clear()
        }
    }
}
