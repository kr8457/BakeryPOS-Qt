#include "Login.h"
#include "ui_Login.h"

Login::Login(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

Login::~Login()
{
    delete ui;
}
