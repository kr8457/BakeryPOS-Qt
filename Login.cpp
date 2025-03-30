#include "Login.h"
#include "ui_Login.h"

Login::Login(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::Login)
{
    ui->setupUi(this);
}

Login::~Login()
{
    delete ui;
}


void Login::on_seePasswordCheckbox_stateChanged(int arg1)
{
    if(arg1 == Qt::Checked)
    {
        ui->passwordLineEdit->setEchoMode(QLineEdit::Normal);
    }
    else
    {
        ui->passwordLineEdit->setEchoMode(QLineEdit::Password);
    }
}

