#include "mainform.h"
#include "ui_mainform.h"
#include "Login.h"
#include <QMessageBox>

Mainform::Mainform(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::Mainform)
{
    ui->setupUi(this);
    ui->pages->setCurrentIndex(0);
}

Mainform::~Mainform()
{
    delete ui;
}

void Mainform::on_dashboard_btn_clicked()
{
    ui->pages->setCurrentIndex(0);
}


void Mainform::on_user_management_btn_clicked()
{
    ui->pages->setCurrentIndex(1);
}


void Mainform::on_cashier_form_btn_clicked()
{
    ui->pages->setCurrentIndex(2);
}


void Mainform::on_invetory_manangement_btn_clicked()
{
    ui->pages->setCurrentIndex(3);
}


void Mainform::on_logout_btn_clicked()
{
    if(QMessageBox::question(this, "Confirm", "Do you want to logout?") == QMessageBox::Yes)
    {
        this->close();
        Login *lgin = new Login();
        lgin->show();
    }
}

