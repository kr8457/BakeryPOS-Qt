#ifndef MAINFORM_H
#define MAINFORM_H

#include <QMainWindow>
#include <QtQuickWidgets/QQuickWidget>
#include <QQmlEngine>


namespace Ui {
class Mainform;
}

class Mainform : public QMainWindow
{
    Q_OBJECT

    // Inside your Mainform class declaration
private:
    QQuickWidget *cashierView = nullptr;

public:
    explicit Mainform(QWidget *parent = nullptr);
    ~Mainform();

private slots:
    void on_dashboard_btn_clicked();

    void on_user_management_btn_clicked();

    void on_cashier_form_btn_clicked();

    void on_invetory_manangement_btn_clicked();

    void on_logout_btn_clicked();

private:
    Ui::Mainform *ui;
};

#endif // MAINFORM_H
