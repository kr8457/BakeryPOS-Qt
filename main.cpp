#include <QCoreApplication>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>
#include <QDebug>

int main(int argc, char *argv[]) {
    QCoreApplication a(argc, argv);

    // Print available SQL drivers
    qDebug() << "🔍 Available SQL Drivers:" << QSqlDatabase::drivers();

    // Check if MySQL driver is available
    if (!QSqlDatabase::isDriverAvailable("QMYSQL")) {
        qDebug() << "❌ Error: MySQL Driver (QMYSQL) is not loaded!";
        return -1; // Exit program
    } else {
        qDebug() << "✅ MySQL Driver (QMYSQL) is loaded successfully!";
    }

    // Establish connection
    qputenv("QT_DEBUG_PLUGINS", "1");
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("127.0.0.1");
    db.setDatabaseName("mydb");  // Replace with actual database name
    db.setUserName("root");   // Your MySQL username
    db.setPassword("khalid");  // Your MySQL password

    // Check if connection is successful
    if (!db.open()) {
        qDebug() << "❌ Error: Connection failed:" << db.lastError().text();
    } else {
        qDebug() << "✅ Success: Connected to MySQL database!";
    }

    return a.exec();
}
