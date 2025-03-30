#include "Login.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Login w;
    w.show();  // ✅ This line is required to display the form
    return a.exec();
}
