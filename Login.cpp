#include "Login.h"
#include "ui_Login.h"
#include "mainform.h"

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


//Hide and show password based on the state of checkbox
void Login::on_seePasswordCheckbox_stateChanged(int arg1)
{
    if(arg1 == Qt::Checked)
    {
        //Qt::Normal means that text(password in this case) is visible
        ui->passwordLineEdit->setEchoMode(QLineEdit::Normal);
    }
    else
    {
        ui->passwordLineEdit->setEchoMode(QLineEdit::Password);
    }
}

//check entered credential with actual credentials and allow or disallow entry based on that
void Login::on_loginButton_clicked()
{
    QString entered_username = ui->usernameLineEdit->text();
    QString entered_password = ui->passwordLineEdit->text();

    if(entered_username == "admin" && entered_password == "1234")
    {
        Mainform *mf = new Mainform();
        this->close();
        mf->show();
    }
    else
    {
        QMessageBox::warning(this, "Login Failed", "Invalid Credentials!");
    }
}

