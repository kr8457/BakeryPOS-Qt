#include <QApplication>
#include <QWidget>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>
#include <QDebug>
#include <QLabel>

int main(int argc, char *argv[]) {
    QApplication a(argc, argv);

    QWidget window;
    window.setWindowTitle("Bakery POS System");
    window.resize(400, 300);

    QLabel *label = new QLabel("Checking MySQL Connection...", &window);
    label->setGeometry(50, 50, 300, 30);

    // Check available SQL drivers
    qDebug() << "🔍 Available SQL Drivers:" << QSqlDatabase::drivers();

    // Check if MySQL driver is available
    if (!QSqlDatabase::isDriverAvailable("QMYSQL")) {
        qDebug() << "❌ Error: MySQL Driver (QMYSQL) is not loaded!";
        label->setText("❌ Error: MySQL Driver is not loaded!");
        window.show();
        return a.exec();  // Run UI
    }

    qDebug() << "✅ MySQL Driver (QMYSQL) is loaded successfully!";
    label->setText("✅ MySQL Driver is loaded successfully!");

    // Establish connection
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("127.0.0.1");
    db.setDatabaseName("mydb");
    db.setUserName("root");
    db.setPassword("khalid");

    // Check connection status
    if (!db.open()) {
        qDebug() << "❌ Error: Connection failed:" << db.lastError().text();
        label->setText("❌ Connection failed!");
    } else {
        qDebug() << "✅ Success: Connected to MySQL database!";
        label->setText("✅ Connected to MySQL database!");
    }

    window.show();
    return a.exec();  // Run the Qt UI event loop
}
