# encoding: utf-8

from sqlalchemy import types, Column, Table, text

from ckan.model import meta
from ckan.model import core
from ckan.model import domain_object

__all__ = [
    'tracking_summary_table',
    'TrackingSummary',
    'tracking_raw_table',
    'usertype_table',
    'Usertype',
    'gender_table',
    'Gender',
]

tracking_raw_table = Table('tracking_raw', meta.metadata,
        Column('user_key', types.Unicode(100), nullable=False),
        Column('url', types.UnicodeText, nullable=False),
        Column('tracking_type', types.Unicode(10), nullable=False),
        Column('gender', types.Unicode(50), nullable=True),
        Column('usertype', types.Unicode(50), nullable=True),
        Column('resource_id', types.UnicodeText, nullable=True),
        Column('package_id', types.UnicodeText, nullable=True),
        Column('access_timestamp', types.DateTime),
    )

usertype_table = Table('usertype', meta.metadata,
        Column('id', types.Integer, nullable=False),
        Column('name', types.Unicode(20), nullable=False),
        Column('value', types.UnicodeText, nullable=True),
        Column('state', types.UnicodeText, nullable=True, default='active')
    )

gender_table = Table('gender', meta.metadata,
        Column('id', types.Integer, nullable=False),
        Column('name', types.Unicode(20), nullable=False),
        Column('value', types.UnicodeText, nullable=True),
        Column('state', types.UnicodeText, nullable=True, default='active')
    )

tracking_summary_table = Table('tracking_summary', meta.metadata,
        Column('url', types.UnicodeText, primary_key=True, nullable=False),
        Column('package_id', types.UnicodeText),
        Column('tracking_type', types.Unicode(10), nullable=False),
        Column('count', types.Integer, nullable=False),
        Column('running_total', types.Integer, nullable=False),
        Column('recent_views', types.Integer, nullable=False),
        Column('tracking_date', types.DateTime),
    )


class TrackingSummary(domain_object.DomainObject):

    @classmethod
    def get_for_package(cls, package_id):
        obj = meta.Session.query(cls).autoflush(False)
        obj = obj.filter_by(package_id=package_id)
        if meta.Session.query(obj.exists()).scalar():
            data = obj.order_by(text('tracking_date desc')).first()
            return {'total': data.running_total,
                    'recent': data.recent_views}

        return {'total': 0, 'recent': 0}


    @classmethod
    def get_for_resource(cls, url):
        obj = meta.Session.query(cls).autoflush(False)
        data = obj.filter_by(url=url).order_by(text('tracking_date desc')).first()
        if data:
            return {'total' : data.running_total,
                    'recent': data.recent_views}

        return {'total': 0, 'recent': 0}


class Usertype(domain_object.DomainObject):

    def __init__(self, name=u'', value=u'', state=u'active'):
        self.name = name
        self.value = value
        self.state = state

    @property
    def display_name(self):
        return self.name

    @classmethod
    def all(cls, state=('active',)):
        """
        Returns all usertypes.
        """
        q = meta.Session.query(cls).autoflush(False)
        if state:
            q = q.filter(cls.state.in_(state))

        return q.order_by(cls.name)


class Gender(domain_object.DomainObject):

    def __init__(self, name=u'', value=u'', state=u'active'):
        self.name = name
        self.value = value
        self.state = state

    @property
    def display_name(self):
        return self.name

    @classmethod
    def all(cls, state=('state',)):
        """
        Returns all gender.
        """
        q = meta.Session.query(cls).autoflush(False)
        if state:
            q = q.filter(cls.state.in_(state))

        return q.order_by(cls.name)


meta.mapper(TrackingSummary, tracking_summary_table)
