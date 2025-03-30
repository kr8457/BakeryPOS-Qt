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


void Login::on_loginButton_clicked()
{
    QString username = ui->usernameLineEdit->text();
    QString password = ui->passwordLineEdit->text();

    if(username == "admin" && password == "1234")
    {
        QMessageBox::information(this, "Login Successful", "Welcome!");
    }
    else
    {
        QMessageBox::information(this, "Login Failed", "Invalid Credentials!");
    }
}

