from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from flask_admin import Admin, BaseView, expose, AdminIndexView
from flask_admin.contrib.sqla import ModelView
from flask_admin.form import Select2Widget

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:1234@localhost/water_park_worker'
app.config['SECRET_KEY'] = 'rly_secret_key'
db = SQLAlchemy(app)
admin = Admin(app, template_mode='bootstrap3', url='/water/admin/')

rates_visitor_relation = db.Table('rates_visitor_relation',
    db.Column('id', db.Integer, primary_key=True),
    db.Column('id_rates', db.Integer, db.ForeignKey('rates.id_rates')),
    db.Column('id_visitor', db.Integer, db.ForeignKey('visitor.id_visitor'))
)

visitor_staff_relation = db.Table('visitor_staff_relation',
    db.Column('id', db.Integer, primary_key=True),
    db.Column('id_visitor', db.Integer, db.ForeignKey('visitor.id_visitor')),
    db.Column('id_staff', db.Integer, db.ForeignKey('staff.id_staff'))
)

staff_service_relation = db.Table('staff_service_relation',
    db.Column('id', db.Integer, primary_key=True),
    db.Column('id_staff', db.Integer, db.ForeignKey('staff.id_staff')),
    db.Column('id_service', db.Integer, db.ForeignKey('service.id_service'))
)

service_session_relation = db.Table('service_session_relation',
    db.Column('id', db.Integer, primary_key=True),
    db.Column('id_service', db.Integer, db.ForeignKey('service.id_service')),
    db.Column('id_session', db.Integer, db.ForeignKey('session.id_session'))
)

class Rates(db.Model):
    id_rates = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name_rate = db.Column(db.String(255))
    duration = db.Column(db.Time)
    description = db.Column(db.String(255))
    
    visitors = db.relationship('Visitor', secondary=rates_visitor_relation, back_populates='rates')
    
    def __repr__(self):
        return str(self.id_rates)

class Visitor(db.Model):
    id_visitor = db.Column(db.Integer, primary_key=True, autoincrement=True)
    full_name = db.Column(db.String(255))
    address_visitor = db.Column(db.String(255))
    number_phone_visitor = db.Column(db.String(15))
    
    rates = db.relationship('Rates', secondary=rates_visitor_relation, back_populates='visitors')
    staff = db.relationship('Staff', secondary=visitor_staff_relation, back_populates='visitors')
    
    def __repr__(self):
        return str(self.id_visitor)

class Staff(db.Model):
    id_staff = db.Column(db.Integer, primary_key=True, autoincrement=True)
    full_name = db.Column(db.String(255))
    number_phone_staff = db.Column(db.String(15))
    
    visitors = db.relationship('Visitor', secondary=visitor_staff_relation, back_populates='staff')
    services = db.relationship('Service', secondary=staff_service_relation, back_populates='staff')
    
    def __repr__(self):
        return str(self.id_staff)

class Service(db.Model):
    id_service = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name_service = db.Column(db.String(255))
    date_event = db.Column(db.String(255))
    description = db.Column(db.String(255))
    
    staff = db.relationship('Staff', secondary=staff_service_relation, back_populates='services')
    sessions = db.relationship('Session', secondary=service_session_relation, back_populates='service')
    
    def __repr__(self):
        return str(self.id_service)

class Session(db.Model):
    id_session = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name_session = db.Column(db.String(255))
    description = db.Column(db.String(255))
    duration = db.Column(db.Time)
    
    service = db.relationship('Service', secondary=service_session_relation, back_populates='sessions')
    
    def __repr__(self):
        return str(self.id_session)   
    
class RatesAdminView(ModelView):
    column_display_pk = True
    column_list = ['id_rates', 'name_rate', 'duration', 'description', 'visitors']
    column_searchable_list = ['id_rates', 'name_rate', 'duration', 'description']
    
    form_ajax_refs = {
        'visitors': {
            'fields': ['id_visitor']
        }
    }

class VisitorAdminView(ModelView):
    column_display_pk = True
    column_list = ['id_visitor', 'full_name', 'address_visitor', 'number_phone_visitor', 'rates', 'staff']
    column_searchable_list = ['id_visitor', 'full_name', 'address_visitor', 'number_phone_visitor']
    
    form_ajax_refs = {
        'rates': {
            'fields': ['id_rates']
        },
        'staff': {
            'fields': ['id_staff']
        }
    }

class StaffAdminView(ModelView):
    column_display_pk = True
    column_list = ['id_staff', 'full_name', 'number_phone_staff', 'visitors', 'services']
    column_searchable_list = ['id_staff', 'full_name', 'number_phone_staff']
    
    form_ajax_refs = {
        'visitors': {
            'fields': ['id_visitor']
        },
        'services': {
            'fields': ['id_service']
        }
    }

class ServiceAdminView(ModelView):
    column_display_pk = True
    column_list = ['id_service', 'name_service', 'date_event', 'description', 'staff', 'sessions']
    column_searchable_list = ['id_service', 'name_service', 'date_event', 'description']

    form_ajax_refs = {
        'staff': {
            'fields': ['id_staff']
        },
        'sessions': {
            'fields': ['id_session'],
        }
    }

class SessionAdminView(ModelView):
    column_display_pk = True
    column_list = ['id_session', 'name_session', 'description', 'duration', 'service']
    column_searchable_list = ['id_session', 'name_session', 'description']
    
    form_ajax_refs = {
        'service': {
            'fields': ['id_service'],
        }
    }

admin.add_view(RatesAdminView(Rates, db.session))
admin.add_view(VisitorAdminView(Visitor, db.session))
admin.add_view(StaffAdminView(Staff, db.session))
admin.add_view(ServiceAdminView(Service, db.session))
admin.add_view(SessionAdminView(Session, db.session))

class RatesReportView(BaseView):
    @expose('/')
    def index(self):
        rates = Rates.query.all()
        return self.render('admin/report_rates.html', rates=rates)

class VisitorReportView(BaseView):
    @expose('/')
    def index(self):
        visitors = Visitor.query.all()
        return self.render('admin/report_visitors.html', visitors=visitors)

class StaffReportView(BaseView):
    @expose('/')
    def index(self):
        staff = Staff.query.all()
        return self.render('admin/report_staff.html', staff=staff)

class ServiceReportView(BaseView):
    @expose('/')
    def index(self):
        services = Service.query.all()
        return self.render('admin/report_services.html', services=services)

class SessionReportView(BaseView):
    @expose('/')
    def index(self):
        sessions = Session.query.all()
        return self.render('admin/report_sessions.html', sessions=sessions)

admin.add_view(RatesReportView(name='Rates Report', endpoint='rates_report'))
admin.add_view(VisitorReportView(name='Visitor Report', endpoint='visitor_report'))
admin.add_view(StaffReportView(name='Staff Report', endpoint='staff_report'))
admin.add_view(ServiceReportView(name='Service Report', endpoint='service_report'))
admin.add_view(SessionReportView(name='Session Report', endpoint='session_report'))

@app.route('/water/')
def index():
    return render_template('index.html')

with app.app_context():
    db.create_all()

if __name__ == '__main__':
    app.run()
