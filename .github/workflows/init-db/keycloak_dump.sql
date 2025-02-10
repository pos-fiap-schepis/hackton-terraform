--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: org; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO postgres;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
5ddcbf29-cc76-42b4-9100-a3b00cb572e0	e47bac88-e9a6-4e8a-9831-bf499f39a2a9
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
918bb55d-c6fb-4a09-8f6d-7f139e7e617a	\N	auth-cookie	f3481901-3ac1-43bb-b067-1ac965a8d282	2bb74c26-f485-4bdf-b23a-a7a79c4d51cd	2	10	f	\N	\N
54f1ba08-bd22-4b0e-bf80-5c9d75302159	\N	auth-spnego	f3481901-3ac1-43bb-b067-1ac965a8d282	2bb74c26-f485-4bdf-b23a-a7a79c4d51cd	3	20	f	\N	\N
2e41f15f-6065-4a0e-b8a8-e4cb7c09353e	\N	identity-provider-redirector	f3481901-3ac1-43bb-b067-1ac965a8d282	2bb74c26-f485-4bdf-b23a-a7a79c4d51cd	2	25	f	\N	\N
94eb2792-53c4-4603-ae76-585bf8410ce0	\N	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	2bb74c26-f485-4bdf-b23a-a7a79c4d51cd	2	30	t	40cb50c7-fc02-4b8e-890e-523b830da700	\N
01524b34-f751-4055-9e72-e0fbf9938eec	\N	auth-username-password-form	f3481901-3ac1-43bb-b067-1ac965a8d282	40cb50c7-fc02-4b8e-890e-523b830da700	0	10	f	\N	\N
94029123-9112-41a2-8f07-378d9a9b723a	\N	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	40cb50c7-fc02-4b8e-890e-523b830da700	1	20	t	c4bb14ab-1302-421e-8486-42f52a096433	\N
afc3b9c8-2f33-497c-8eb6-75127724290f	\N	conditional-user-configured	f3481901-3ac1-43bb-b067-1ac965a8d282	c4bb14ab-1302-421e-8486-42f52a096433	0	10	f	\N	\N
d180f0d9-2e2d-403e-bc9b-bb2a9f891968	\N	auth-otp-form	f3481901-3ac1-43bb-b067-1ac965a8d282	c4bb14ab-1302-421e-8486-42f52a096433	0	20	f	\N	\N
a79678b5-5e66-471e-a106-320a91e038c2	\N	direct-grant-validate-username	f3481901-3ac1-43bb-b067-1ac965a8d282	a93745d1-b83a-45b2-97e0-d7a933d59cd5	0	10	f	\N	\N
05e3e313-008d-45de-af77-7f348607bc88	\N	direct-grant-validate-password	f3481901-3ac1-43bb-b067-1ac965a8d282	a93745d1-b83a-45b2-97e0-d7a933d59cd5	0	20	f	\N	\N
a3588e3a-c63c-4559-b831-dab72b3b448a	\N	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	a93745d1-b83a-45b2-97e0-d7a933d59cd5	1	30	t	a6502285-a88b-4d47-b297-7a91ce0133ff	\N
3f723017-5760-4f93-8e42-bd1090d9014e	\N	conditional-user-configured	f3481901-3ac1-43bb-b067-1ac965a8d282	a6502285-a88b-4d47-b297-7a91ce0133ff	0	10	f	\N	\N
782870ba-1bbb-41ce-a6c9-5055c86d91d6	\N	direct-grant-validate-otp	f3481901-3ac1-43bb-b067-1ac965a8d282	a6502285-a88b-4d47-b297-7a91ce0133ff	0	20	f	\N	\N
bb25c516-3609-4777-bb5f-cadfb6707e53	\N	registration-page-form	f3481901-3ac1-43bb-b067-1ac965a8d282	44f600ce-1655-4e9e-a84d-d774ed1e3ce7	0	10	t	8aa6cd46-5dd8-4669-b5bd-ca15a7ced573	\N
a1c4d17c-3193-4dfe-8907-c5dde19da84a	\N	registration-user-creation	f3481901-3ac1-43bb-b067-1ac965a8d282	8aa6cd46-5dd8-4669-b5bd-ca15a7ced573	0	20	f	\N	\N
71c48804-4324-49a9-a07d-d1653ebd6d6f	\N	registration-password-action	f3481901-3ac1-43bb-b067-1ac965a8d282	8aa6cd46-5dd8-4669-b5bd-ca15a7ced573	0	50	f	\N	\N
74526996-7535-4064-a82d-c50890fd58f6	\N	registration-recaptcha-action	f3481901-3ac1-43bb-b067-1ac965a8d282	8aa6cd46-5dd8-4669-b5bd-ca15a7ced573	3	60	f	\N	\N
71a5b10f-6289-43d3-9ed2-8750cc4da2cd	\N	registration-terms-and-conditions	f3481901-3ac1-43bb-b067-1ac965a8d282	8aa6cd46-5dd8-4669-b5bd-ca15a7ced573	3	70	f	\N	\N
aac02057-c151-4dba-b387-0b90536753b0	\N	reset-credentials-choose-user	f3481901-3ac1-43bb-b067-1ac965a8d282	9b51756b-853f-4111-8e20-93e28254aa80	0	10	f	\N	\N
99718a65-2882-447b-a022-36facea729b7	\N	reset-credential-email	f3481901-3ac1-43bb-b067-1ac965a8d282	9b51756b-853f-4111-8e20-93e28254aa80	0	20	f	\N	\N
ce53131d-f34c-4e2c-b895-a06101cb1cd0	\N	reset-password	f3481901-3ac1-43bb-b067-1ac965a8d282	9b51756b-853f-4111-8e20-93e28254aa80	0	30	f	\N	\N
995b68f7-85d3-473e-90e3-ba855c3b71a0	\N	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	9b51756b-853f-4111-8e20-93e28254aa80	1	40	t	820e03f1-bdc1-46eb-8d70-ebd2f7614f8e	\N
304650b7-d9e0-4930-a10c-a0c73a4a0aed	\N	conditional-user-configured	f3481901-3ac1-43bb-b067-1ac965a8d282	820e03f1-bdc1-46eb-8d70-ebd2f7614f8e	0	10	f	\N	\N
f6236e9d-b93d-4530-9f55-22ae4388d2b2	\N	reset-otp	f3481901-3ac1-43bb-b067-1ac965a8d282	820e03f1-bdc1-46eb-8d70-ebd2f7614f8e	0	20	f	\N	\N
8af9998c-15d2-4afd-ba1c-0691485c38b1	\N	client-secret	f3481901-3ac1-43bb-b067-1ac965a8d282	f73ee8df-eed0-426b-9cd0-80f8f485c986	2	10	f	\N	\N
1166a223-738c-4c46-9f42-f7f36d45a398	\N	client-jwt	f3481901-3ac1-43bb-b067-1ac965a8d282	f73ee8df-eed0-426b-9cd0-80f8f485c986	2	20	f	\N	\N
698f1813-6b9c-401d-ad31-740e9a8d190d	\N	client-secret-jwt	f3481901-3ac1-43bb-b067-1ac965a8d282	f73ee8df-eed0-426b-9cd0-80f8f485c986	2	30	f	\N	\N
45e9fbdc-bc74-4a06-8304-a501a0f82db1	\N	client-x509	f3481901-3ac1-43bb-b067-1ac965a8d282	f73ee8df-eed0-426b-9cd0-80f8f485c986	2	40	f	\N	\N
d6f7effd-bd99-4f2f-a1c7-b6db5d948b43	\N	idp-review-profile	f3481901-3ac1-43bb-b067-1ac965a8d282	3aa9076a-cdee-4c86-b42e-93b0aa659ee1	0	10	f	\N	ad987eb1-6976-4e0e-87ed-505885703c74
d7e369cf-a7fb-48f3-a86e-5e90ad86e156	\N	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	3aa9076a-cdee-4c86-b42e-93b0aa659ee1	0	20	t	915f26da-fb36-4e1b-9c78-6a44cef27cec	\N
9c29000d-7942-4b53-ac1a-ae2cc2ef8c76	\N	idp-create-user-if-unique	f3481901-3ac1-43bb-b067-1ac965a8d282	915f26da-fb36-4e1b-9c78-6a44cef27cec	2	10	f	\N	5280065b-fc1b-4b66-bba8-420e55f9f29d
9fa03cf9-74b8-4885-8883-adaf3cbe77b1	\N	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	915f26da-fb36-4e1b-9c78-6a44cef27cec	2	20	t	eddff186-c378-47ec-8b5d-0ff4e11fbe51	\N
a454329b-34c4-45aa-bdce-93350810e8fb	\N	idp-confirm-link	f3481901-3ac1-43bb-b067-1ac965a8d282	eddff186-c378-47ec-8b5d-0ff4e11fbe51	0	10	f	\N	\N
63a8e118-ac54-4fe0-b5f6-b733ae7853f2	\N	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	eddff186-c378-47ec-8b5d-0ff4e11fbe51	0	20	t	b2b1ce82-3cee-4363-878f-ea844656a604	\N
937e74d4-3f97-486a-bfea-1f4fb9f8a01e	\N	idp-email-verification	f3481901-3ac1-43bb-b067-1ac965a8d282	b2b1ce82-3cee-4363-878f-ea844656a604	2	10	f	\N	\N
952ca77d-11a8-48e6-88b9-e434eec7c8a8	\N	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	b2b1ce82-3cee-4363-878f-ea844656a604	2	20	t	f00c92e9-b592-447f-95c0-005b67d826b6	\N
8c4d205c-0007-4978-a946-5625b818041e	\N	idp-username-password-form	f3481901-3ac1-43bb-b067-1ac965a8d282	f00c92e9-b592-447f-95c0-005b67d826b6	0	10	f	\N	\N
ec27081f-008a-45a3-a079-19edb75fd563	\N	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	f00c92e9-b592-447f-95c0-005b67d826b6	1	20	t	adc3ae95-e1df-44b5-bb6a-eb21a3bcb416	\N
183040f5-4a2c-49ac-a589-c3a47627b818	\N	conditional-user-configured	f3481901-3ac1-43bb-b067-1ac965a8d282	adc3ae95-e1df-44b5-bb6a-eb21a3bcb416	0	10	f	\N	\N
408e06eb-069b-44d5-ae76-bfbc669f81d9	\N	auth-otp-form	f3481901-3ac1-43bb-b067-1ac965a8d282	adc3ae95-e1df-44b5-bb6a-eb21a3bcb416	0	20	f	\N	\N
689543f7-03d3-4477-b0fd-4fd4968a37bf	\N	http-basic-authenticator	f3481901-3ac1-43bb-b067-1ac965a8d282	bb243202-a80a-4560-a808-227e4c2f6598	0	10	f	\N	\N
f6fe4727-2035-4f73-8c9f-800558e1f24e	\N	docker-http-basic-authenticator	f3481901-3ac1-43bb-b067-1ac965a8d282	8e79df5e-1261-48ab-9723-e0f3784077f7	0	10	f	\N	\N
0fb45d38-1e16-454e-96e2-81e1b593d60d	\N	auth-cookie	503310e2-70f4-445d-bfe0-0c00deb5ea32	f2901a84-4bfc-4d3e-98af-d766afa5f6d8	2	10	f	\N	\N
b4b16ba8-903c-471f-a21b-4202c5de6434	\N	auth-spnego	503310e2-70f4-445d-bfe0-0c00deb5ea32	f2901a84-4bfc-4d3e-98af-d766afa5f6d8	3	20	f	\N	\N
8e927e1e-74a4-4bf1-b73e-19a47ae545a9	\N	identity-provider-redirector	503310e2-70f4-445d-bfe0-0c00deb5ea32	f2901a84-4bfc-4d3e-98af-d766afa5f6d8	2	25	f	\N	\N
a83363f2-6f32-44f7-b00d-da2b60ce4ad7	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	f2901a84-4bfc-4d3e-98af-d766afa5f6d8	2	30	t	64240d65-f91a-4985-baf3-aaa7253c4a1b	\N
5ac2bd72-14e0-46d7-bc40-3c209d43a3ef	\N	auth-username-password-form	503310e2-70f4-445d-bfe0-0c00deb5ea32	64240d65-f91a-4985-baf3-aaa7253c4a1b	0	10	f	\N	\N
8c407284-322b-42a7-b8c2-9312bb32c2a2	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	64240d65-f91a-4985-baf3-aaa7253c4a1b	1	20	t	014a82d4-005b-473f-9a40-fb83872cd169	\N
b9caeed2-d7ab-4c0c-aa99-17f712448e86	\N	conditional-user-configured	503310e2-70f4-445d-bfe0-0c00deb5ea32	014a82d4-005b-473f-9a40-fb83872cd169	0	10	f	\N	\N
78ba7ae4-c1ea-4763-bc94-2472e1a2bc54	\N	auth-otp-form	503310e2-70f4-445d-bfe0-0c00deb5ea32	014a82d4-005b-473f-9a40-fb83872cd169	0	20	f	\N	\N
fd52ae63-8fb6-43e2-abc2-78e6a7274e5f	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	f2901a84-4bfc-4d3e-98af-d766afa5f6d8	2	26	t	2dea8cef-2404-4d8a-99ab-994f502533b5	\N
b114c7ad-d5ed-41c7-9ca8-b0098b69beae	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	2dea8cef-2404-4d8a-99ab-994f502533b5	1	10	t	866a2fa7-7754-4ae6-885a-d79998f7a396	\N
0a049a75-045f-4818-9e23-32f0e3b59da8	\N	conditional-user-configured	503310e2-70f4-445d-bfe0-0c00deb5ea32	866a2fa7-7754-4ae6-885a-d79998f7a396	0	10	f	\N	\N
e0d940ab-5017-455e-b60f-f40b8206e523	\N	organization	503310e2-70f4-445d-bfe0-0c00deb5ea32	866a2fa7-7754-4ae6-885a-d79998f7a396	2	20	f	\N	\N
f85ad946-ec6c-40ab-a03b-8b2fdfe23b56	\N	direct-grant-validate-username	503310e2-70f4-445d-bfe0-0c00deb5ea32	cce45f3c-249f-47dd-a8e0-2759d25228c2	0	10	f	\N	\N
f4832029-7a5f-40cb-8a51-bead92119b75	\N	direct-grant-validate-password	503310e2-70f4-445d-bfe0-0c00deb5ea32	cce45f3c-249f-47dd-a8e0-2759d25228c2	0	20	f	\N	\N
95191cdc-3f2d-4723-9fca-5f10e27991d1	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	cce45f3c-249f-47dd-a8e0-2759d25228c2	1	30	t	c38eeee6-611e-457c-b655-62043666b799	\N
9477d3e3-034a-44fb-afa3-1b65ef290b1b	\N	conditional-user-configured	503310e2-70f4-445d-bfe0-0c00deb5ea32	c38eeee6-611e-457c-b655-62043666b799	0	10	f	\N	\N
42191f10-05ac-4e89-ba88-d012a1295098	\N	direct-grant-validate-otp	503310e2-70f4-445d-bfe0-0c00deb5ea32	c38eeee6-611e-457c-b655-62043666b799	0	20	f	\N	\N
1498b7e8-4288-421c-b4ad-db00cff3d393	\N	registration-page-form	503310e2-70f4-445d-bfe0-0c00deb5ea32	6c0cd7ad-fb92-483c-a86a-c90c3e809a7f	0	10	t	e67f12aa-7ef4-44b2-83e6-19db292496bc	\N
1396ec0d-3aef-42b9-9cc2-ddb7fa069a35	\N	registration-user-creation	503310e2-70f4-445d-bfe0-0c00deb5ea32	e67f12aa-7ef4-44b2-83e6-19db292496bc	0	20	f	\N	\N
b29ca6ad-1722-4dc2-a228-9cb73ca52fcf	\N	registration-password-action	503310e2-70f4-445d-bfe0-0c00deb5ea32	e67f12aa-7ef4-44b2-83e6-19db292496bc	0	50	f	\N	\N
3b02d977-0dc2-4559-8216-48ee3b21414b	\N	registration-recaptcha-action	503310e2-70f4-445d-bfe0-0c00deb5ea32	e67f12aa-7ef4-44b2-83e6-19db292496bc	3	60	f	\N	\N
2c6c833f-2e61-48e0-b195-aee4b11c6987	\N	registration-terms-and-conditions	503310e2-70f4-445d-bfe0-0c00deb5ea32	e67f12aa-7ef4-44b2-83e6-19db292496bc	3	70	f	\N	\N
d59d86bd-762f-49ae-9aeb-573948eb94da	\N	reset-credentials-choose-user	503310e2-70f4-445d-bfe0-0c00deb5ea32	c8f47c36-0f64-45b8-ab1e-eb3caf741ea3	0	10	f	\N	\N
c160260d-d151-4966-b021-502f456586e3	\N	reset-credential-email	503310e2-70f4-445d-bfe0-0c00deb5ea32	c8f47c36-0f64-45b8-ab1e-eb3caf741ea3	0	20	f	\N	\N
b4a1d95a-011b-49fc-8471-7a627e2d609e	\N	reset-password	503310e2-70f4-445d-bfe0-0c00deb5ea32	c8f47c36-0f64-45b8-ab1e-eb3caf741ea3	0	30	f	\N	\N
8b7c09a5-858d-4cd5-85f7-46c91e40045a	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	c8f47c36-0f64-45b8-ab1e-eb3caf741ea3	1	40	t	269ac062-260c-4728-bd92-315f4ace6874	\N
0e64db97-6185-40f4-810d-999b1b0fee22	\N	conditional-user-configured	503310e2-70f4-445d-bfe0-0c00deb5ea32	269ac062-260c-4728-bd92-315f4ace6874	0	10	f	\N	\N
ea388273-e776-48f3-aac4-e5067f18d33f	\N	reset-otp	503310e2-70f4-445d-bfe0-0c00deb5ea32	269ac062-260c-4728-bd92-315f4ace6874	0	20	f	\N	\N
f6650514-e3db-4fc6-9707-d7b9e08dba12	\N	client-secret	503310e2-70f4-445d-bfe0-0c00deb5ea32	05bba604-0a3a-4a4c-b6fd-d8bc5a745ff8	2	10	f	\N	\N
95b86944-fa69-4806-b30e-fb87bbc8c234	\N	client-jwt	503310e2-70f4-445d-bfe0-0c00deb5ea32	05bba604-0a3a-4a4c-b6fd-d8bc5a745ff8	2	20	f	\N	\N
938d5244-1674-446a-993a-855fc344abc1	\N	client-secret-jwt	503310e2-70f4-445d-bfe0-0c00deb5ea32	05bba604-0a3a-4a4c-b6fd-d8bc5a745ff8	2	30	f	\N	\N
71806114-8fe2-4fd2-ac47-0183c6a78fe2	\N	client-x509	503310e2-70f4-445d-bfe0-0c00deb5ea32	05bba604-0a3a-4a4c-b6fd-d8bc5a745ff8	2	40	f	\N	\N
0f93fd12-e084-473d-be2a-37bd841d4b87	\N	idp-review-profile	503310e2-70f4-445d-bfe0-0c00deb5ea32	0fbc65da-ec9c-4d86-be80-b485f57d1636	0	10	f	\N	ce8948ea-c2f2-42c8-9c45-bfd972f281f8
ea31da3d-1123-46b4-8b39-c3350e0522a7	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	0fbc65da-ec9c-4d86-be80-b485f57d1636	0	20	t	13caff46-e920-4407-bee4-e4b52e1676b7	\N
09ce4030-7b82-4cc6-8f09-7794bcbe59bb	\N	idp-create-user-if-unique	503310e2-70f4-445d-bfe0-0c00deb5ea32	13caff46-e920-4407-bee4-e4b52e1676b7	2	10	f	\N	a77371c3-9d3a-467e-a9dc-0b74994c8b49
7ee697f5-b6ad-4267-ae63-f3e23f627f77	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	13caff46-e920-4407-bee4-e4b52e1676b7	2	20	t	8f228812-8ee3-4691-9757-acef98d3ed8f	\N
3e438835-af25-4e20-98c8-a1ac77c79b86	\N	idp-confirm-link	503310e2-70f4-445d-bfe0-0c00deb5ea32	8f228812-8ee3-4691-9757-acef98d3ed8f	0	10	f	\N	\N
fc19e78b-5456-4249-8571-793067e943d3	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	8f228812-8ee3-4691-9757-acef98d3ed8f	0	20	t	dda533fe-1ae1-41d2-993f-9592393bc20f	\N
c1950f4a-9c66-471c-b423-4cb966bfb7cd	\N	idp-email-verification	503310e2-70f4-445d-bfe0-0c00deb5ea32	dda533fe-1ae1-41d2-993f-9592393bc20f	2	10	f	\N	\N
af889c54-39da-4fdb-871a-b1c2231f43c5	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	dda533fe-1ae1-41d2-993f-9592393bc20f	2	20	t	4eb9a2fe-b8da-493c-b318-1f32e0070e49	\N
2c8319eb-7268-4c26-81c5-2349a550505f	\N	idp-username-password-form	503310e2-70f4-445d-bfe0-0c00deb5ea32	4eb9a2fe-b8da-493c-b318-1f32e0070e49	0	10	f	\N	\N
696604c7-24cd-4f4a-a460-82b6c644a25e	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	4eb9a2fe-b8da-493c-b318-1f32e0070e49	1	20	t	9e3ac670-4ba1-4b1a-a966-049303693613	\N
f345fc49-9411-46e5-90c2-6790fe06f67f	\N	conditional-user-configured	503310e2-70f4-445d-bfe0-0c00deb5ea32	9e3ac670-4ba1-4b1a-a966-049303693613	0	10	f	\N	\N
17e59b87-1d9e-4a94-a72d-5a6b0abd431f	\N	auth-otp-form	503310e2-70f4-445d-bfe0-0c00deb5ea32	9e3ac670-4ba1-4b1a-a966-049303693613	0	20	f	\N	\N
85a7f5dc-6b70-43d1-92e0-621c813eaf4e	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	0fbc65da-ec9c-4d86-be80-b485f57d1636	1	50	t	be707d53-b837-417c-992f-5922fa49ccc2	\N
4a08ed73-9979-452b-877b-77e028c42ed0	\N	conditional-user-configured	503310e2-70f4-445d-bfe0-0c00deb5ea32	be707d53-b837-417c-992f-5922fa49ccc2	0	10	f	\N	\N
4fd1f782-7a2b-414d-9cac-e5934b5a4af6	\N	idp-add-organization-member	503310e2-70f4-445d-bfe0-0c00deb5ea32	be707d53-b837-417c-992f-5922fa49ccc2	0	20	f	\N	\N
aa62117a-543a-44d1-953a-b6778f91fd6f	\N	http-basic-authenticator	503310e2-70f4-445d-bfe0-0c00deb5ea32	ad5e6da9-ca32-4f8d-850d-9abf811a4a98	0	10	f	\N	\N
147626a6-8efc-49b3-a94e-099baaddbb70	\N	docker-http-basic-authenticator	503310e2-70f4-445d-bfe0-0c00deb5ea32	441d2f1a-49eb-40e6-825a-d939e79184a1	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
2bb74c26-f485-4bdf-b23a-a7a79c4d51cd	browser	Browser based authentication	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	t	t
40cb50c7-fc02-4b8e-890e-523b830da700	forms	Username, password, otp and other auth forms.	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	f	t
c4bb14ab-1302-421e-8486-42f52a096433	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	f	t
a93745d1-b83a-45b2-97e0-d7a933d59cd5	direct grant	OpenID Connect Resource Owner Grant	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	t	t
a6502285-a88b-4d47-b297-7a91ce0133ff	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	f	t
44f600ce-1655-4e9e-a84d-d774ed1e3ce7	registration	Registration flow	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	t	t
8aa6cd46-5dd8-4669-b5bd-ca15a7ced573	registration form	Registration form	f3481901-3ac1-43bb-b067-1ac965a8d282	form-flow	f	t
9b51756b-853f-4111-8e20-93e28254aa80	reset credentials	Reset credentials for a user if they forgot their password or something	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	t	t
820e03f1-bdc1-46eb-8d70-ebd2f7614f8e	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	f	t
f73ee8df-eed0-426b-9cd0-80f8f485c986	clients	Base authentication for clients	f3481901-3ac1-43bb-b067-1ac965a8d282	client-flow	t	t
3aa9076a-cdee-4c86-b42e-93b0aa659ee1	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	t	t
915f26da-fb36-4e1b-9c78-6a44cef27cec	User creation or linking	Flow for the existing/non-existing user alternatives	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	f	t
eddff186-c378-47ec-8b5d-0ff4e11fbe51	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	f	t
b2b1ce82-3cee-4363-878f-ea844656a604	Account verification options	Method with which to verity the existing account	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	f	t
f00c92e9-b592-447f-95c0-005b67d826b6	Verify Existing Account by Re-authentication	Reauthentication of existing account	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	f	t
adc3ae95-e1df-44b5-bb6a-eb21a3bcb416	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	f	t
bb243202-a80a-4560-a808-227e4c2f6598	saml ecp	SAML ECP Profile Authentication Flow	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	t	t
8e79df5e-1261-48ab-9723-e0f3784077f7	docker auth	Used by Docker clients to authenticate against the IDP	f3481901-3ac1-43bb-b067-1ac965a8d282	basic-flow	t	t
f2901a84-4bfc-4d3e-98af-d766afa5f6d8	browser	Browser based authentication	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	t	t
64240d65-f91a-4985-baf3-aaa7253c4a1b	forms	Username, password, otp and other auth forms.	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
014a82d4-005b-473f-9a40-fb83872cd169	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
2dea8cef-2404-4d8a-99ab-994f502533b5	Organization	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
866a2fa7-7754-4ae6-885a-d79998f7a396	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
cce45f3c-249f-47dd-a8e0-2759d25228c2	direct grant	OpenID Connect Resource Owner Grant	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	t	t
c38eeee6-611e-457c-b655-62043666b799	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
6c0cd7ad-fb92-483c-a86a-c90c3e809a7f	registration	Registration flow	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	t	t
e67f12aa-7ef4-44b2-83e6-19db292496bc	registration form	Registration form	503310e2-70f4-445d-bfe0-0c00deb5ea32	form-flow	f	t
c8f47c36-0f64-45b8-ab1e-eb3caf741ea3	reset credentials	Reset credentials for a user if they forgot their password or something	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	t	t
269ac062-260c-4728-bd92-315f4ace6874	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
05bba604-0a3a-4a4c-b6fd-d8bc5a745ff8	clients	Base authentication for clients	503310e2-70f4-445d-bfe0-0c00deb5ea32	client-flow	t	t
0fbc65da-ec9c-4d86-be80-b485f57d1636	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	t	t
13caff46-e920-4407-bee4-e4b52e1676b7	User creation or linking	Flow for the existing/non-existing user alternatives	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
8f228812-8ee3-4691-9757-acef98d3ed8f	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
dda533fe-1ae1-41d2-993f-9592393bc20f	Account verification options	Method with which to verity the existing account	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
4eb9a2fe-b8da-493c-b318-1f32e0070e49	Verify Existing Account by Re-authentication	Reauthentication of existing account	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
9e3ac670-4ba1-4b1a-a966-049303693613	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
be707d53-b837-417c-992f-5922fa49ccc2	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	f	t
ad5e6da9-ca32-4f8d-850d-9abf811a4a98	saml ecp	SAML ECP Profile Authentication Flow	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	t	t
441d2f1a-49eb-40e6-825a-d939e79184a1	docker auth	Used by Docker clients to authenticate against the IDP	503310e2-70f4-445d-bfe0-0c00deb5ea32	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
ad987eb1-6976-4e0e-87ed-505885703c74	review profile config	f3481901-3ac1-43bb-b067-1ac965a8d282
5280065b-fc1b-4b66-bba8-420e55f9f29d	create unique user config	f3481901-3ac1-43bb-b067-1ac965a8d282
ce8948ea-c2f2-42c8-9c45-bfd972f281f8	review profile config	503310e2-70f4-445d-bfe0-0c00deb5ea32
a77371c3-9d3a-467e-a9dc-0b74994c8b49	create unique user config	503310e2-70f4-445d-bfe0-0c00deb5ea32
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
5280065b-fc1b-4b66-bba8-420e55f9f29d	false	require.password.update.after.registration
ad987eb1-6976-4e0e-87ed-505885703c74	missing	update.profile.on.first.login
a77371c3-9d3a-467e-a9dc-0b74994c8b49	false	require.password.update.after.registration
ce8948ea-c2f2-42c8-9c45-bfd972f281f8	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	f	master-realm	0	f	\N	\N	t	\N	f	f3481901-3ac1-43bb-b067-1ac965a8d282	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
b904d985-b7d6-4352-b9aa-42626d8ce09e	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	f3481901-3ac1-43bb-b067-1ac965a8d282	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
cc320807-24a8-4be4-949b-4b75fcdb982c	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	f3481901-3ac1-43bb-b067-1ac965a8d282	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ebe6a098-26ec-4c11-b936-b291f3c3f840	t	f	broker	0	f	\N	\N	t	\N	f	f3481901-3ac1-43bb-b067-1ac965a8d282	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
8cc74036-ce0b-40fb-bad4-213c98d2cef6	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	f3481901-3ac1-43bb-b067-1ac965a8d282	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
fa5dda93-8d73-490c-ae72-f725a79f7925	t	t	admin-cli	0	t	\N	\N	f	\N	f	f3481901-3ac1-43bb-b067-1ac965a8d282	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
14577c13-02e1-456f-a07b-4d2db438e606	t	f	hackaton-realm	0	f	\N	\N	t	\N	f	f3481901-3ac1-43bb-b067-1ac965a8d282	\N	0	f	f	hackaton Realm	f	client-secret	\N	\N	\N	t	f	f	f
d3adf521-0ac4-460b-813c-42e7205c2f29	t	f	realm-management	0	f	\N	\N	t	\N	f	503310e2-70f4-445d-bfe0-0c00deb5ea32	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	t	f	account	0	t	\N	/realms/hackaton/account/	f	\N	f	503310e2-70f4-445d-bfe0-0c00deb5ea32	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
cc8ea444-0ef6-47dc-94c8-9baf324015d3	t	f	account-console	0	t	\N	/realms/hackaton/account/	f	\N	f	503310e2-70f4-445d-bfe0-0c00deb5ea32	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	t	f	broker	0	f	\N	\N	t	\N	f	503310e2-70f4-445d-bfe0-0c00deb5ea32	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
56129fd8-266b-47e1-8227-c4dcfbc9f44e	t	t	security-admin-console	0	t	\N	/admin/hackaton/console/	f	\N	f	503310e2-70f4-445d-bfe0-0c00deb5ea32	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
624c4e19-9555-4276-b671-7371b1cbeb8c	t	t	admin-cli	0	t	\N	\N	f	\N	f	503310e2-70f4-445d-bfe0-0c00deb5ea32	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	t	t	hackaton-app	0	f	mQEilYGAST1DJTM6Stsfb7cFuQHTXomW		f		f	503310e2-70f4-445d-bfe0-0c00deb5ea32	openid-connect	-1	t	f		t	client-secret			\N	t	f	t	t
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
b904d985-b7d6-4352-b9aa-42626d8ce09e	post.logout.redirect.uris	+
cc320807-24a8-4be4-949b-4b75fcdb982c	post.logout.redirect.uris	+
cc320807-24a8-4be4-949b-4b75fcdb982c	pkce.code.challenge.method	S256
8cc74036-ce0b-40fb-bad4-213c98d2cef6	post.logout.redirect.uris	+
8cc74036-ce0b-40fb-bad4-213c98d2cef6	pkce.code.challenge.method	S256
8cc74036-ce0b-40fb-bad4-213c98d2cef6	client.use.lightweight.access.token.enabled	true
fa5dda93-8d73-490c-ae72-f725a79f7925	client.use.lightweight.access.token.enabled	true
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	post.logout.redirect.uris	+
cc8ea444-0ef6-47dc-94c8-9baf324015d3	post.logout.redirect.uris	+
cc8ea444-0ef6-47dc-94c8-9baf324015d3	pkce.code.challenge.method	S256
56129fd8-266b-47e1-8227-c4dcfbc9f44e	post.logout.redirect.uris	+
56129fd8-266b-47e1-8227-c4dcfbc9f44e	pkce.code.challenge.method	S256
56129fd8-266b-47e1-8227-c4dcfbc9f44e	client.use.lightweight.access.token.enabled	true
624c4e19-9555-4276-b671-7371b1cbeb8c	client.use.lightweight.access.token.enabled	true
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	client.secret.creation.time	1738203547
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	oauth2.device.authorization.grant.enabled	true
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	oidc.ciba.grant.enabled	false
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	backchannel.logout.session.required	true
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
1c0cd907-f413-41ad-a99e-e5716cfbdf49	offline_access	f3481901-3ac1-43bb-b067-1ac965a8d282	OpenID Connect built-in scope: offline_access	openid-connect
1c29c3e9-540e-43c8-a428-fd7fad46c123	role_list	f3481901-3ac1-43bb-b067-1ac965a8d282	SAML role list	saml
2e44bf17-d2ed-4361-aa01-1ec0d6dbf995	saml_organization	f3481901-3ac1-43bb-b067-1ac965a8d282	Organization Membership	saml
68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	profile	f3481901-3ac1-43bb-b067-1ac965a8d282	OpenID Connect built-in scope: profile	openid-connect
4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	email	f3481901-3ac1-43bb-b067-1ac965a8d282	OpenID Connect built-in scope: email	openid-connect
a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	address	f3481901-3ac1-43bb-b067-1ac965a8d282	OpenID Connect built-in scope: address	openid-connect
2baec8d4-9279-4cc3-812d-26a55ce86a19	phone	f3481901-3ac1-43bb-b067-1ac965a8d282	OpenID Connect built-in scope: phone	openid-connect
731c0c0a-78b4-4a73-93ee-60ac219ddb7e	roles	f3481901-3ac1-43bb-b067-1ac965a8d282	OpenID Connect scope for add user roles to the access token	openid-connect
d1378567-9a9b-4b5a-bca2-d5913c6abe4b	web-origins	f3481901-3ac1-43bb-b067-1ac965a8d282	OpenID Connect scope for add allowed web origins to the access token	openid-connect
c017baf6-10d4-4df8-97a2-fd2cb7ba59c0	microprofile-jwt	f3481901-3ac1-43bb-b067-1ac965a8d282	Microprofile - JWT built-in scope	openid-connect
4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5	acr	f3481901-3ac1-43bb-b067-1ac965a8d282	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
8a6d7158-e3d7-4b35-96e3-0c18e9e0a663	basic	f3481901-3ac1-43bb-b067-1ac965a8d282	OpenID Connect scope for add all basic claims to the token	openid-connect
9d684b80-7dfa-462c-bd69-01f018106004	organization	f3481901-3ac1-43bb-b067-1ac965a8d282	Additional claims about the organization a subject belongs to	openid-connect
283e2fb0-c8ef-4894-98b8-c39c13921fe8	offline_access	503310e2-70f4-445d-bfe0-0c00deb5ea32	OpenID Connect built-in scope: offline_access	openid-connect
47065527-0797-4d89-a387-3ced372d8c61	role_list	503310e2-70f4-445d-bfe0-0c00deb5ea32	SAML role list	saml
a94aff13-c1a7-4c99-82ad-809246f11c85	saml_organization	503310e2-70f4-445d-bfe0-0c00deb5ea32	Organization Membership	saml
9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	profile	503310e2-70f4-445d-bfe0-0c00deb5ea32	OpenID Connect built-in scope: profile	openid-connect
ee8e6063-f7ad-4396-a283-3a7ec8b40438	email	503310e2-70f4-445d-bfe0-0c00deb5ea32	OpenID Connect built-in scope: email	openid-connect
7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	address	503310e2-70f4-445d-bfe0-0c00deb5ea32	OpenID Connect built-in scope: address	openid-connect
8f3984b6-bc11-469b-a9cc-e5226b78a886	phone	503310e2-70f4-445d-bfe0-0c00deb5ea32	OpenID Connect built-in scope: phone	openid-connect
7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	roles	503310e2-70f4-445d-bfe0-0c00deb5ea32	OpenID Connect scope for add user roles to the access token	openid-connect
a1e10876-e6de-48ce-be9e-4c0147e6983d	web-origins	503310e2-70f4-445d-bfe0-0c00deb5ea32	OpenID Connect scope for add allowed web origins to the access token	openid-connect
3519f343-cbda-441c-87a0-5042d7963e55	microprofile-jwt	503310e2-70f4-445d-bfe0-0c00deb5ea32	Microprofile - JWT built-in scope	openid-connect
6cbf8bad-0262-4b4a-91b3-507944b1f138	acr	503310e2-70f4-445d-bfe0-0c00deb5ea32	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
47396527-458e-4dfa-a421-41e1e32561eb	basic	503310e2-70f4-445d-bfe0-0c00deb5ea32	OpenID Connect scope for add all basic claims to the token	openid-connect
01a7bfb5-2588-426c-9176-e59c5c2351a9	organization	503310e2-70f4-445d-bfe0-0c00deb5ea32	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
1c0cd907-f413-41ad-a99e-e5716cfbdf49	true	display.on.consent.screen
1c0cd907-f413-41ad-a99e-e5716cfbdf49	${offlineAccessScopeConsentText}	consent.screen.text
1c29c3e9-540e-43c8-a428-fd7fad46c123	true	display.on.consent.screen
1c29c3e9-540e-43c8-a428-fd7fad46c123	${samlRoleListScopeConsentText}	consent.screen.text
2e44bf17-d2ed-4361-aa01-1ec0d6dbf995	false	display.on.consent.screen
68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	true	display.on.consent.screen
68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	${profileScopeConsentText}	consent.screen.text
68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	true	include.in.token.scope
4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	true	display.on.consent.screen
4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	${emailScopeConsentText}	consent.screen.text
4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	true	include.in.token.scope
a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	true	display.on.consent.screen
a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	${addressScopeConsentText}	consent.screen.text
a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	true	include.in.token.scope
2baec8d4-9279-4cc3-812d-26a55ce86a19	true	display.on.consent.screen
2baec8d4-9279-4cc3-812d-26a55ce86a19	${phoneScopeConsentText}	consent.screen.text
2baec8d4-9279-4cc3-812d-26a55ce86a19	true	include.in.token.scope
731c0c0a-78b4-4a73-93ee-60ac219ddb7e	true	display.on.consent.screen
731c0c0a-78b4-4a73-93ee-60ac219ddb7e	${rolesScopeConsentText}	consent.screen.text
731c0c0a-78b4-4a73-93ee-60ac219ddb7e	false	include.in.token.scope
d1378567-9a9b-4b5a-bca2-d5913c6abe4b	false	display.on.consent.screen
d1378567-9a9b-4b5a-bca2-d5913c6abe4b		consent.screen.text
d1378567-9a9b-4b5a-bca2-d5913c6abe4b	false	include.in.token.scope
c017baf6-10d4-4df8-97a2-fd2cb7ba59c0	false	display.on.consent.screen
c017baf6-10d4-4df8-97a2-fd2cb7ba59c0	true	include.in.token.scope
4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5	false	display.on.consent.screen
4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5	false	include.in.token.scope
8a6d7158-e3d7-4b35-96e3-0c18e9e0a663	false	display.on.consent.screen
8a6d7158-e3d7-4b35-96e3-0c18e9e0a663	false	include.in.token.scope
9d684b80-7dfa-462c-bd69-01f018106004	true	display.on.consent.screen
9d684b80-7dfa-462c-bd69-01f018106004	${organizationScopeConsentText}	consent.screen.text
9d684b80-7dfa-462c-bd69-01f018106004	true	include.in.token.scope
283e2fb0-c8ef-4894-98b8-c39c13921fe8	true	display.on.consent.screen
283e2fb0-c8ef-4894-98b8-c39c13921fe8	${offlineAccessScopeConsentText}	consent.screen.text
47065527-0797-4d89-a387-3ced372d8c61	true	display.on.consent.screen
47065527-0797-4d89-a387-3ced372d8c61	${samlRoleListScopeConsentText}	consent.screen.text
a94aff13-c1a7-4c99-82ad-809246f11c85	false	display.on.consent.screen
9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	true	display.on.consent.screen
9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	${profileScopeConsentText}	consent.screen.text
9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	true	include.in.token.scope
ee8e6063-f7ad-4396-a283-3a7ec8b40438	true	display.on.consent.screen
ee8e6063-f7ad-4396-a283-3a7ec8b40438	${emailScopeConsentText}	consent.screen.text
ee8e6063-f7ad-4396-a283-3a7ec8b40438	true	include.in.token.scope
7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	true	display.on.consent.screen
7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	${addressScopeConsentText}	consent.screen.text
7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	true	include.in.token.scope
8f3984b6-bc11-469b-a9cc-e5226b78a886	true	display.on.consent.screen
8f3984b6-bc11-469b-a9cc-e5226b78a886	${phoneScopeConsentText}	consent.screen.text
8f3984b6-bc11-469b-a9cc-e5226b78a886	true	include.in.token.scope
7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	true	display.on.consent.screen
7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	${rolesScopeConsentText}	consent.screen.text
7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	false	include.in.token.scope
a1e10876-e6de-48ce-be9e-4c0147e6983d	false	display.on.consent.screen
a1e10876-e6de-48ce-be9e-4c0147e6983d		consent.screen.text
a1e10876-e6de-48ce-be9e-4c0147e6983d	false	include.in.token.scope
3519f343-cbda-441c-87a0-5042d7963e55	false	display.on.consent.screen
3519f343-cbda-441c-87a0-5042d7963e55	true	include.in.token.scope
6cbf8bad-0262-4b4a-91b3-507944b1f138	false	display.on.consent.screen
6cbf8bad-0262-4b4a-91b3-507944b1f138	false	include.in.token.scope
47396527-458e-4dfa-a421-41e1e32561eb	false	display.on.consent.screen
47396527-458e-4dfa-a421-41e1e32561eb	false	include.in.token.scope
01a7bfb5-2588-426c-9176-e59c5c2351a9	true	display.on.consent.screen
01a7bfb5-2588-426c-9176-e59c5c2351a9	${organizationScopeConsentText}	consent.screen.text
01a7bfb5-2588-426c-9176-e59c5c2351a9	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
b904d985-b7d6-4352-b9aa-42626d8ce09e	731c0c0a-78b4-4a73-93ee-60ac219ddb7e	t
b904d985-b7d6-4352-b9aa-42626d8ce09e	8a6d7158-e3d7-4b35-96e3-0c18e9e0a663	t
b904d985-b7d6-4352-b9aa-42626d8ce09e	4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5	t
b904d985-b7d6-4352-b9aa-42626d8ce09e	4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	t
b904d985-b7d6-4352-b9aa-42626d8ce09e	d1378567-9a9b-4b5a-bca2-d5913c6abe4b	t
b904d985-b7d6-4352-b9aa-42626d8ce09e	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	t
b904d985-b7d6-4352-b9aa-42626d8ce09e	1c0cd907-f413-41ad-a99e-e5716cfbdf49	f
b904d985-b7d6-4352-b9aa-42626d8ce09e	2baec8d4-9279-4cc3-812d-26a55ce86a19	f
b904d985-b7d6-4352-b9aa-42626d8ce09e	a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	f
b904d985-b7d6-4352-b9aa-42626d8ce09e	9d684b80-7dfa-462c-bd69-01f018106004	f
b904d985-b7d6-4352-b9aa-42626d8ce09e	c017baf6-10d4-4df8-97a2-fd2cb7ba59c0	f
cc320807-24a8-4be4-949b-4b75fcdb982c	731c0c0a-78b4-4a73-93ee-60ac219ddb7e	t
cc320807-24a8-4be4-949b-4b75fcdb982c	8a6d7158-e3d7-4b35-96e3-0c18e9e0a663	t
cc320807-24a8-4be4-949b-4b75fcdb982c	4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5	t
cc320807-24a8-4be4-949b-4b75fcdb982c	4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	t
cc320807-24a8-4be4-949b-4b75fcdb982c	d1378567-9a9b-4b5a-bca2-d5913c6abe4b	t
cc320807-24a8-4be4-949b-4b75fcdb982c	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	t
cc320807-24a8-4be4-949b-4b75fcdb982c	1c0cd907-f413-41ad-a99e-e5716cfbdf49	f
cc320807-24a8-4be4-949b-4b75fcdb982c	2baec8d4-9279-4cc3-812d-26a55ce86a19	f
cc320807-24a8-4be4-949b-4b75fcdb982c	a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	f
cc320807-24a8-4be4-949b-4b75fcdb982c	9d684b80-7dfa-462c-bd69-01f018106004	f
cc320807-24a8-4be4-949b-4b75fcdb982c	c017baf6-10d4-4df8-97a2-fd2cb7ba59c0	f
fa5dda93-8d73-490c-ae72-f725a79f7925	731c0c0a-78b4-4a73-93ee-60ac219ddb7e	t
fa5dda93-8d73-490c-ae72-f725a79f7925	8a6d7158-e3d7-4b35-96e3-0c18e9e0a663	t
fa5dda93-8d73-490c-ae72-f725a79f7925	4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5	t
fa5dda93-8d73-490c-ae72-f725a79f7925	4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	t
fa5dda93-8d73-490c-ae72-f725a79f7925	d1378567-9a9b-4b5a-bca2-d5913c6abe4b	t
fa5dda93-8d73-490c-ae72-f725a79f7925	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	t
fa5dda93-8d73-490c-ae72-f725a79f7925	1c0cd907-f413-41ad-a99e-e5716cfbdf49	f
fa5dda93-8d73-490c-ae72-f725a79f7925	2baec8d4-9279-4cc3-812d-26a55ce86a19	f
fa5dda93-8d73-490c-ae72-f725a79f7925	a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	f
fa5dda93-8d73-490c-ae72-f725a79f7925	9d684b80-7dfa-462c-bd69-01f018106004	f
fa5dda93-8d73-490c-ae72-f725a79f7925	c017baf6-10d4-4df8-97a2-fd2cb7ba59c0	f
ebe6a098-26ec-4c11-b936-b291f3c3f840	731c0c0a-78b4-4a73-93ee-60ac219ddb7e	t
ebe6a098-26ec-4c11-b936-b291f3c3f840	8a6d7158-e3d7-4b35-96e3-0c18e9e0a663	t
ebe6a098-26ec-4c11-b936-b291f3c3f840	4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5	t
ebe6a098-26ec-4c11-b936-b291f3c3f840	4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	t
ebe6a098-26ec-4c11-b936-b291f3c3f840	d1378567-9a9b-4b5a-bca2-d5913c6abe4b	t
ebe6a098-26ec-4c11-b936-b291f3c3f840	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	t
ebe6a098-26ec-4c11-b936-b291f3c3f840	1c0cd907-f413-41ad-a99e-e5716cfbdf49	f
ebe6a098-26ec-4c11-b936-b291f3c3f840	2baec8d4-9279-4cc3-812d-26a55ce86a19	f
ebe6a098-26ec-4c11-b936-b291f3c3f840	a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	f
ebe6a098-26ec-4c11-b936-b291f3c3f840	9d684b80-7dfa-462c-bd69-01f018106004	f
ebe6a098-26ec-4c11-b936-b291f3c3f840	c017baf6-10d4-4df8-97a2-fd2cb7ba59c0	f
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	731c0c0a-78b4-4a73-93ee-60ac219ddb7e	t
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	8a6d7158-e3d7-4b35-96e3-0c18e9e0a663	t
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5	t
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	t
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	d1378567-9a9b-4b5a-bca2-d5913c6abe4b	t
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	t
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	1c0cd907-f413-41ad-a99e-e5716cfbdf49	f
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	2baec8d4-9279-4cc3-812d-26a55ce86a19	f
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	f
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	9d684b80-7dfa-462c-bd69-01f018106004	f
d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	c017baf6-10d4-4df8-97a2-fd2cb7ba59c0	f
8cc74036-ce0b-40fb-bad4-213c98d2cef6	731c0c0a-78b4-4a73-93ee-60ac219ddb7e	t
8cc74036-ce0b-40fb-bad4-213c98d2cef6	8a6d7158-e3d7-4b35-96e3-0c18e9e0a663	t
8cc74036-ce0b-40fb-bad4-213c98d2cef6	4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5	t
8cc74036-ce0b-40fb-bad4-213c98d2cef6	4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	t
8cc74036-ce0b-40fb-bad4-213c98d2cef6	d1378567-9a9b-4b5a-bca2-d5913c6abe4b	t
8cc74036-ce0b-40fb-bad4-213c98d2cef6	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	t
8cc74036-ce0b-40fb-bad4-213c98d2cef6	1c0cd907-f413-41ad-a99e-e5716cfbdf49	f
8cc74036-ce0b-40fb-bad4-213c98d2cef6	2baec8d4-9279-4cc3-812d-26a55ce86a19	f
8cc74036-ce0b-40fb-bad4-213c98d2cef6	a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	f
8cc74036-ce0b-40fb-bad4-213c98d2cef6	9d684b80-7dfa-462c-bd69-01f018106004	f
8cc74036-ce0b-40fb-bad4-213c98d2cef6	c017baf6-10d4-4df8-97a2-fd2cb7ba59c0	f
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	t
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	ee8e6063-f7ad-4396-a283-3a7ec8b40438	t
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	47396527-458e-4dfa-a421-41e1e32561eb	t
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	6cbf8bad-0262-4b4a-91b3-507944b1f138	t
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	t
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	a1e10876-e6de-48ce-be9e-4c0147e6983d	t
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	283e2fb0-c8ef-4894-98b8-c39c13921fe8	f
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	8f3984b6-bc11-469b-a9cc-e5226b78a886	f
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	3519f343-cbda-441c-87a0-5042d7963e55	f
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	f
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	01a7bfb5-2588-426c-9176-e59c5c2351a9	f
cc8ea444-0ef6-47dc-94c8-9baf324015d3	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	t
cc8ea444-0ef6-47dc-94c8-9baf324015d3	ee8e6063-f7ad-4396-a283-3a7ec8b40438	t
cc8ea444-0ef6-47dc-94c8-9baf324015d3	47396527-458e-4dfa-a421-41e1e32561eb	t
cc8ea444-0ef6-47dc-94c8-9baf324015d3	6cbf8bad-0262-4b4a-91b3-507944b1f138	t
cc8ea444-0ef6-47dc-94c8-9baf324015d3	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	t
cc8ea444-0ef6-47dc-94c8-9baf324015d3	a1e10876-e6de-48ce-be9e-4c0147e6983d	t
cc8ea444-0ef6-47dc-94c8-9baf324015d3	283e2fb0-c8ef-4894-98b8-c39c13921fe8	f
cc8ea444-0ef6-47dc-94c8-9baf324015d3	8f3984b6-bc11-469b-a9cc-e5226b78a886	f
cc8ea444-0ef6-47dc-94c8-9baf324015d3	3519f343-cbda-441c-87a0-5042d7963e55	f
cc8ea444-0ef6-47dc-94c8-9baf324015d3	7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	f
cc8ea444-0ef6-47dc-94c8-9baf324015d3	01a7bfb5-2588-426c-9176-e59c5c2351a9	f
624c4e19-9555-4276-b671-7371b1cbeb8c	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	t
624c4e19-9555-4276-b671-7371b1cbeb8c	ee8e6063-f7ad-4396-a283-3a7ec8b40438	t
624c4e19-9555-4276-b671-7371b1cbeb8c	47396527-458e-4dfa-a421-41e1e32561eb	t
624c4e19-9555-4276-b671-7371b1cbeb8c	6cbf8bad-0262-4b4a-91b3-507944b1f138	t
624c4e19-9555-4276-b671-7371b1cbeb8c	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	t
624c4e19-9555-4276-b671-7371b1cbeb8c	a1e10876-e6de-48ce-be9e-4c0147e6983d	t
624c4e19-9555-4276-b671-7371b1cbeb8c	283e2fb0-c8ef-4894-98b8-c39c13921fe8	f
624c4e19-9555-4276-b671-7371b1cbeb8c	8f3984b6-bc11-469b-a9cc-e5226b78a886	f
624c4e19-9555-4276-b671-7371b1cbeb8c	3519f343-cbda-441c-87a0-5042d7963e55	f
624c4e19-9555-4276-b671-7371b1cbeb8c	7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	f
624c4e19-9555-4276-b671-7371b1cbeb8c	01a7bfb5-2588-426c-9176-e59c5c2351a9	f
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	t
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	ee8e6063-f7ad-4396-a283-3a7ec8b40438	t
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	47396527-458e-4dfa-a421-41e1e32561eb	t
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	6cbf8bad-0262-4b4a-91b3-507944b1f138	t
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	t
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	a1e10876-e6de-48ce-be9e-4c0147e6983d	t
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	283e2fb0-c8ef-4894-98b8-c39c13921fe8	f
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	8f3984b6-bc11-469b-a9cc-e5226b78a886	f
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	3519f343-cbda-441c-87a0-5042d7963e55	f
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	f
00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	01a7bfb5-2588-426c-9176-e59c5c2351a9	f
d3adf521-0ac4-460b-813c-42e7205c2f29	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	t
d3adf521-0ac4-460b-813c-42e7205c2f29	ee8e6063-f7ad-4396-a283-3a7ec8b40438	t
d3adf521-0ac4-460b-813c-42e7205c2f29	47396527-458e-4dfa-a421-41e1e32561eb	t
d3adf521-0ac4-460b-813c-42e7205c2f29	6cbf8bad-0262-4b4a-91b3-507944b1f138	t
d3adf521-0ac4-460b-813c-42e7205c2f29	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	t
d3adf521-0ac4-460b-813c-42e7205c2f29	a1e10876-e6de-48ce-be9e-4c0147e6983d	t
d3adf521-0ac4-460b-813c-42e7205c2f29	283e2fb0-c8ef-4894-98b8-c39c13921fe8	f
d3adf521-0ac4-460b-813c-42e7205c2f29	8f3984b6-bc11-469b-a9cc-e5226b78a886	f
d3adf521-0ac4-460b-813c-42e7205c2f29	3519f343-cbda-441c-87a0-5042d7963e55	f
d3adf521-0ac4-460b-813c-42e7205c2f29	7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	f
d3adf521-0ac4-460b-813c-42e7205c2f29	01a7bfb5-2588-426c-9176-e59c5c2351a9	f
56129fd8-266b-47e1-8227-c4dcfbc9f44e	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	t
56129fd8-266b-47e1-8227-c4dcfbc9f44e	ee8e6063-f7ad-4396-a283-3a7ec8b40438	t
56129fd8-266b-47e1-8227-c4dcfbc9f44e	47396527-458e-4dfa-a421-41e1e32561eb	t
56129fd8-266b-47e1-8227-c4dcfbc9f44e	6cbf8bad-0262-4b4a-91b3-507944b1f138	t
56129fd8-266b-47e1-8227-c4dcfbc9f44e	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	t
56129fd8-266b-47e1-8227-c4dcfbc9f44e	a1e10876-e6de-48ce-be9e-4c0147e6983d	t
56129fd8-266b-47e1-8227-c4dcfbc9f44e	283e2fb0-c8ef-4894-98b8-c39c13921fe8	f
56129fd8-266b-47e1-8227-c4dcfbc9f44e	8f3984b6-bc11-469b-a9cc-e5226b78a886	f
56129fd8-266b-47e1-8227-c4dcfbc9f44e	3519f343-cbda-441c-87a0-5042d7963e55	f
56129fd8-266b-47e1-8227-c4dcfbc9f44e	7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	f
56129fd8-266b-47e1-8227-c4dcfbc9f44e	01a7bfb5-2588-426c-9176-e59c5c2351a9	f
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	t
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	47396527-458e-4dfa-a421-41e1e32561eb	t
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	6cbf8bad-0262-4b4a-91b3-507944b1f138	t
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	t
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	a1e10876-e6de-48ce-be9e-4c0147e6983d	t
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	283e2fb0-c8ef-4894-98b8-c39c13921fe8	f
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	8f3984b6-bc11-469b-a9cc-e5226b78a886	f
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	3519f343-cbda-441c-87a0-5042d7963e55	f
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	f
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	01a7bfb5-2588-426c-9176-e59c5c2351a9	f
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	ee8e6063-f7ad-4396-a283-3a7ec8b40438	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
1c0cd907-f413-41ad-a99e-e5716cfbdf49	5054ac72-e29a-4243-bc4f-a5e714152309
283e2fb0-c8ef-4894-98b8-c39c13921fe8	b0eea1cd-408b-48ba-b6be-9ab967d7a1db
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
60f8aad2-b0e7-4119-ac40-2ab9203f9c84	Trusted Hosts	f3481901-3ac1-43bb-b067-1ac965a8d282	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3481901-3ac1-43bb-b067-1ac965a8d282	anonymous
ba614578-aa6d-4e38-b465-e6bb48c0bfb5	Consent Required	f3481901-3ac1-43bb-b067-1ac965a8d282	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3481901-3ac1-43bb-b067-1ac965a8d282	anonymous
b591007a-cd6d-4d87-a81d-f12f2bcb7ca7	Full Scope Disabled	f3481901-3ac1-43bb-b067-1ac965a8d282	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3481901-3ac1-43bb-b067-1ac965a8d282	anonymous
12def038-854e-42bb-9138-ee50d5a57787	Max Clients Limit	f3481901-3ac1-43bb-b067-1ac965a8d282	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3481901-3ac1-43bb-b067-1ac965a8d282	anonymous
d55e262a-e97b-4421-83b8-7d90298c21d5	Allowed Protocol Mapper Types	f3481901-3ac1-43bb-b067-1ac965a8d282	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3481901-3ac1-43bb-b067-1ac965a8d282	anonymous
89ad4e47-7075-4b13-99d7-370d3c663aaf	Allowed Client Scopes	f3481901-3ac1-43bb-b067-1ac965a8d282	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3481901-3ac1-43bb-b067-1ac965a8d282	anonymous
800d2dc5-2cb5-453a-a622-45477b113e20	Allowed Protocol Mapper Types	f3481901-3ac1-43bb-b067-1ac965a8d282	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3481901-3ac1-43bb-b067-1ac965a8d282	authenticated
0e23c807-2fba-4369-b223-c188178fd802	Allowed Client Scopes	f3481901-3ac1-43bb-b067-1ac965a8d282	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3481901-3ac1-43bb-b067-1ac965a8d282	authenticated
af78bcb6-45e0-4cca-87a6-1d870fe3ee7a	rsa-generated	f3481901-3ac1-43bb-b067-1ac965a8d282	rsa-generated	org.keycloak.keys.KeyProvider	f3481901-3ac1-43bb-b067-1ac965a8d282	\N
c940195a-43e7-49c6-95c9-e5b5ee23f1af	rsa-enc-generated	f3481901-3ac1-43bb-b067-1ac965a8d282	rsa-enc-generated	org.keycloak.keys.KeyProvider	f3481901-3ac1-43bb-b067-1ac965a8d282	\N
8cfec1f1-5508-49a4-9d8e-d23c53fc93ce	hmac-generated-hs512	f3481901-3ac1-43bb-b067-1ac965a8d282	hmac-generated	org.keycloak.keys.KeyProvider	f3481901-3ac1-43bb-b067-1ac965a8d282	\N
1dba2f28-72cf-463f-8e60-b2e5c0dc3c04	aes-generated	f3481901-3ac1-43bb-b067-1ac965a8d282	aes-generated	org.keycloak.keys.KeyProvider	f3481901-3ac1-43bb-b067-1ac965a8d282	\N
ef799296-e45a-46b6-bb59-62fcdf66fa01	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	f3481901-3ac1-43bb-b067-1ac965a8d282	\N
3af89921-dcf4-49ad-8a9d-6565f1558ae9	rsa-generated	503310e2-70f4-445d-bfe0-0c00deb5ea32	rsa-generated	org.keycloak.keys.KeyProvider	503310e2-70f4-445d-bfe0-0c00deb5ea32	\N
d0a7ef06-f3a7-41d7-b945-e2aa6eba2e7c	rsa-enc-generated	503310e2-70f4-445d-bfe0-0c00deb5ea32	rsa-enc-generated	org.keycloak.keys.KeyProvider	503310e2-70f4-445d-bfe0-0c00deb5ea32	\N
fb09905f-2e5a-4fd8-8f1a-5d32685947bc	hmac-generated-hs512	503310e2-70f4-445d-bfe0-0c00deb5ea32	hmac-generated	org.keycloak.keys.KeyProvider	503310e2-70f4-445d-bfe0-0c00deb5ea32	\N
e96ad033-0f02-4592-80c8-f6a2902c7768	aes-generated	503310e2-70f4-445d-bfe0-0c00deb5ea32	aes-generated	org.keycloak.keys.KeyProvider	503310e2-70f4-445d-bfe0-0c00deb5ea32	\N
47122e7d-c283-442d-ab94-33bbf8fe3d12	Trusted Hosts	503310e2-70f4-445d-bfe0-0c00deb5ea32	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	503310e2-70f4-445d-bfe0-0c00deb5ea32	anonymous
4e82f590-15f2-4e0b-b8e1-e6119924b302	Consent Required	503310e2-70f4-445d-bfe0-0c00deb5ea32	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	503310e2-70f4-445d-bfe0-0c00deb5ea32	anonymous
4b628878-37fe-47d4-b37c-a1dd8157340c	Full Scope Disabled	503310e2-70f4-445d-bfe0-0c00deb5ea32	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	503310e2-70f4-445d-bfe0-0c00deb5ea32	anonymous
2c051b49-b1d1-403e-af4f-c9948dd373d7	Max Clients Limit	503310e2-70f4-445d-bfe0-0c00deb5ea32	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	503310e2-70f4-445d-bfe0-0c00deb5ea32	anonymous
1038c1d1-9b32-4b6b-986f-2ae715a9d8a9	Allowed Protocol Mapper Types	503310e2-70f4-445d-bfe0-0c00deb5ea32	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	503310e2-70f4-445d-bfe0-0c00deb5ea32	anonymous
95d0fb1f-7cc5-48fb-b257-3762e0b6eacb	Allowed Client Scopes	503310e2-70f4-445d-bfe0-0c00deb5ea32	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	503310e2-70f4-445d-bfe0-0c00deb5ea32	anonymous
e903c19a-a338-410b-bc85-d99abad73baa	Allowed Protocol Mapper Types	503310e2-70f4-445d-bfe0-0c00deb5ea32	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	503310e2-70f4-445d-bfe0-0c00deb5ea32	authenticated
d00f33a4-cfc2-4cbe-a184-a5d8ed600f09	Allowed Client Scopes	503310e2-70f4-445d-bfe0-0c00deb5ea32	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	503310e2-70f4-445d-bfe0-0c00deb5ea32	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
c15ea562-4a0a-4326-8867-bac766c6715a	d55e262a-e97b-4421-83b8-7d90298c21d5	allowed-protocol-mapper-types	saml-user-attribute-mapper
5cdfab3c-988d-4070-b9a0-df597d2811a0	d55e262a-e97b-4421-83b8-7d90298c21d5	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
bf6eafe7-d724-4253-b680-3968208d1e6f	d55e262a-e97b-4421-83b8-7d90298c21d5	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b5e6e104-7968-498d-9d41-0a27f31f9720	d55e262a-e97b-4421-83b8-7d90298c21d5	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3b689e9a-906d-467d-8fc5-319ef1037d57	d55e262a-e97b-4421-83b8-7d90298c21d5	allowed-protocol-mapper-types	oidc-full-name-mapper
0feb398b-ea05-4aeb-a067-2a485827501e	d55e262a-e97b-4421-83b8-7d90298c21d5	allowed-protocol-mapper-types	saml-user-property-mapper
63fd1a3a-96db-4e07-bdb7-eff46c572ec5	d55e262a-e97b-4421-83b8-7d90298c21d5	allowed-protocol-mapper-types	saml-role-list-mapper
4dfeac8e-5de1-4111-8abb-5821f59d1206	d55e262a-e97b-4421-83b8-7d90298c21d5	allowed-protocol-mapper-types	oidc-address-mapper
0faf4f82-70f3-4bc2-a284-4e5aa70f01c2	12def038-854e-42bb-9138-ee50d5a57787	max-clients	200
2887b66a-654a-441b-955a-cab355285d18	60f8aad2-b0e7-4119-ac40-2ab9203f9c84	host-sending-registration-request-must-match	true
6ca16557-c839-4a1d-af7d-3f91b8be1e3e	60f8aad2-b0e7-4119-ac40-2ab9203f9c84	client-uris-must-match	true
fa3ee089-0d54-4250-a2d3-d3ba69b49e35	0e23c807-2fba-4369-b223-c188178fd802	allow-default-scopes	true
0237e980-34e4-4227-a206-f7dcca3fa780	89ad4e47-7075-4b13-99d7-370d3c663aaf	allow-default-scopes	true
b96c9861-c93c-4b2d-ba46-8e81795419e2	800d2dc5-2cb5-453a-a622-45477b113e20	allowed-protocol-mapper-types	oidc-address-mapper
67d56cda-5a03-4a0c-adcd-f135a43e75f0	800d2dc5-2cb5-453a-a622-45477b113e20	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
0ff0b24e-491c-40c3-a632-a292bf074199	800d2dc5-2cb5-453a-a622-45477b113e20	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2cc787ca-47e5-4a61-a479-ad9a385e322d	800d2dc5-2cb5-453a-a622-45477b113e20	allowed-protocol-mapper-types	saml-user-attribute-mapper
22624e96-7199-4738-8669-afe89fb0e98c	800d2dc5-2cb5-453a-a622-45477b113e20	allowed-protocol-mapper-types	saml-user-property-mapper
89cd68c1-1cf2-4675-96dc-f554b3704422	800d2dc5-2cb5-453a-a622-45477b113e20	allowed-protocol-mapper-types	oidc-full-name-mapper
0fde4804-359c-4144-a47a-531cac813138	800d2dc5-2cb5-453a-a622-45477b113e20	allowed-protocol-mapper-types	saml-role-list-mapper
bb953c54-24e7-47a4-9120-cc98250f0393	800d2dc5-2cb5-453a-a622-45477b113e20	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
63c62030-2086-484e-85b4-ffbdd56dfa1a	ef799296-e45a-46b6-bb59-62fcdf66fa01	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
a6f90507-0646-4cb2-876b-775105d41773	1dba2f28-72cf-463f-8e60-b2e5c0dc3c04	priority	100
699c6511-cd80-415f-957c-e620aac642eb	1dba2f28-72cf-463f-8e60-b2e5c0dc3c04	secret	AlxoEMW1A9H1uNcECx5dgw
072db3fe-4492-4cd6-8840-4d2e053e37f2	1dba2f28-72cf-463f-8e60-b2e5c0dc3c04	kid	76783361-0a66-4ec6-9c36-205c2d0d8bfd
275817ed-40df-49f3-bf5f-16ed19e37c56	af78bcb6-45e0-4cca-87a6-1d870fe3ee7a	priority	100
1ccee398-64da-4411-bfad-a527105c7c15	af78bcb6-45e0-4cca-87a6-1d870fe3ee7a	keyUse	SIG
3b08a766-c1e2-417b-8db9-815185408269	af78bcb6-45e0-4cca-87a6-1d870fe3ee7a	certificate	MIICmzCCAYMCBgGUtNADcDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMTMwMDEyMzM4WhcNMzUwMTMwMDEyNTE4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCU4ANmQB/i/MTA4BPfi9MXBQosW+mDIUS1vDgtS1p8ZsnO5xV6g9EtUFNz5k0KS2hRv8bUOPnsH8xHbjMKfSGeC58yAVeLb/yfAhJ6jeTVBW8OwDPstsaFx4rItErxEy6oLQM6PtdHQgSVZkmD1o0W2mC+b0D/EkRvnaP5T8s/WWF5EyXiqtR8gmGvzSsXJaiCHKohi5QSEV/qRnpl133ISWgEeJh5aoKxv2SGfjVWQ3oFs7R/aSmTZn7BpmH06U5JUpkmQsIdEsoL78Wwi8u5WYNfMUNo/ESsAiMYSRwG9eD2M/HnY+IAjGmJGGfK9/bcY6fFzn+wKosDJ+o5KI2TAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAILb08/F7wuDxmPri10r1PQl5efaBuD1ktzVfaT613STlxYjK189ZbC6QZJK70hbuCHvbkKSgigLhzea4+vcJZmTt7BPJrKhPxak/cDR0aUbDbyY763Y7I7k1SBgKdSaZeyZt1Ykm8qBIQyWpNboi6s2Loq1FAP2LtQ5QTPLmlLkxA1SpVx/fcNvOLiMifscwwwc/jHcqVUmedmrMtXRN2cA2dj/gy4VxKhom5VhNGz7yYzqQ5kD0w4h84Fvp1IRMs0P6K9vdQurmdhn8mG4l0oQXRZn7zay4mL+qL+ToThsXB/ZYVH7bIxWHfACax6uOL8Me0UORtAtZ70UCJMKsIc=
4bad4774-2885-4dd7-9c69-5c3a200e478f	af78bcb6-45e0-4cca-87a6-1d870fe3ee7a	privateKey	MIIEowIBAAKCAQEAlOADZkAf4vzEwOAT34vTFwUKLFvpgyFEtbw4LUtafGbJzucVeoPRLVBTc+ZNCktoUb/G1Dj57B/MR24zCn0hngufMgFXi2/8nwISeo3k1QVvDsAz7LbGhceKyLRK8RMuqC0DOj7XR0IElWZJg9aNFtpgvm9A/xJEb52j+U/LP1lheRMl4qrUfIJhr80rFyWoghyqIYuUEhFf6kZ6Zdd9yEloBHiYeWqCsb9khn41VkN6BbO0f2kpk2Z+waZh9OlOSVKZJkLCHRLKC+/FsIvLuVmDXzFDaPxErAIjGEkcBvXg9jPx52PiAIxpiRhnyvf23GOnxc5/sCqLAyfqOSiNkwIDAQABAoIBADeoK/0tGf6tSw1keGmJh6hCfRQqZHlelaZvsHzWgASkFOxiHfiIkUokjp50yfaATIbLcJTknCK3nJJT04cnUssYQzLZp5X8jvAPQUNKCvPMrUFRf9gOWNeoyuzP4niQGFBNS7iZx7ffKYGFFRTRwDt79tEbHKx/ctBbmfLZ7v1GZenTN065cyaKNSo0YXQzbzuTGgm9yIxObpP+PUut88t9lB1HCN2Ao3QAsVyb8EqItfGxviIrCXdpAWtd4A05BpIcf3IbXSUr8oZggVn0BWdo8TlcMcH66l/P6j4GMBqgEGTC8JnLLI8WUoyf8sntIJ3ENnewLNzHK4J0HHTCcnECgYEAzevzLBAtEzo5UB2klt5kDXZCAiO831zAmzsIsUiG4BC/PI0lKSp8SwOBP2+exmjeSQjup0ZMfTfjOQuagXJ5ov5MthT8DWIq5+qMLSJwRlNZYHDxePkoYDzSC6c28XGMPPkKo+8lholb1KcF6MpC2UBkdmDooS+KhcOVVu5+OvkCgYEAuRSEElXM/NOEPeu1FZGXTi0bvoqCcFpXFJczfaKQDgNsdU67UsHb/uWA7aAR0Tjth49TDJ413llgWDYshjulfeSFoAtNNnmB4JSlj3shCMDOJ4ZdhAMCaoCnogV/pRr23O9zCUXzqtcr4i6aSqgle/NRM4F6e85PSr7fCe+zg+sCgYA3nIgwlzHFJo1B4K+JewfkRtKuxz4DyIXPplLDpgWez4cF8Exf4LRugcTO//MOPFYDvWDOVgLkMkqwJj0UxnipFypaZjJn3uIdfc9bhRhzNaFGlVnxRMCttN84/HCvJe4srUk9WqF0wvXE6VKEOtNw3p4DBkrs9OzhER/suT3n6QKBgCpI2qfJvIyi0prHCFdGLRhqS+VrhcOfkDefF9+DTYA2HghrFXch3V5OFvezU37Gj9Yh06qVVt9W8iEVN3Tvma66kCDxlBF3D0o9C9pNGk4Cptb25tSrT1j/zczBjtks4Ou3NUQQHEyS3m7NkOivo+i+vXWUBmTUzN7Z3uFJR21DAoGBAMR9d9uqdSrAQXur39M4SoJamVgnlHIUXCOsPg+NncMKpLtqSxZxh14X3608Qaa48hhEwD0lQUXZiSNlfkPdUWiWyFKE5edfzutnbwHEwFq6Ta1cG/OPJ566GK/99bRatC/zH+t48UrbKDE1iAbwrbYZwnY8DROABQeF5gkDLd3C
40432cbe-02ea-4f7b-a314-d47612ed45a4	8cfec1f1-5508-49a4-9d8e-d23c53fc93ce	kid	0723bad4-c10e-457f-bf42-7b93f8146ae0
0245f1bc-0d0f-4b31-a259-8a24638822fb	8cfec1f1-5508-49a4-9d8e-d23c53fc93ce	algorithm	HS512
c46b902d-3ffe-4e60-a138-23faf33e1c1d	8cfec1f1-5508-49a4-9d8e-d23c53fc93ce	secret	ZY4bQ_JTBclqjz12koTluwhvhrC1fiJc-kLKfSXJtdFlXdrVkBmO-FTBmbbpcgJcMuaAp-U9D1-PE4xvzARl7_AgqsnBTBZ8HSPod8EIFWiOmRK-JIB_AW821VT7FfcOWmsJwWKlNz9aD5JjpCBpGRAe4KqOzSKuWcuhP3Rz94c
b1954628-0f8a-4adb-a1a4-26af7918540e	8cfec1f1-5508-49a4-9d8e-d23c53fc93ce	priority	100
64946970-9cb1-418a-bb85-07dbaf0885f8	c940195a-43e7-49c6-95c9-e5b5ee23f1af	algorithm	RSA-OAEP
94816aea-fd5e-415f-a4ed-f62c88176990	c940195a-43e7-49c6-95c9-e5b5ee23f1af	keyUse	ENC
6ae16bdb-cf7a-4be4-9c2f-59b9cbb66ffd	c940195a-43e7-49c6-95c9-e5b5ee23f1af	certificate	MIICmzCCAYMCBgGUtNAFfzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMTMwMDEyMzM5WhcNMzUwMTMwMDEyNTE5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCSWftfQ7tBJsjX9NN5gaJ0huu/Iq35RVVqKTybl6Bk/ocp5VRm6kwwJhX29yBdsyLJh+5I6ZPMyYJvpH2bGmxtrF6JHgpYhAV2inee9j8aoA4QdLcKu6VIrqYUovYifkJ4KZ7JksNm+PN5Eq0B4AlXtXtris+nrv2gw1w7XHPNOPBZu8YMXxqDQoW9SHa9y1FNzJs0Dvh7bqQtIzWowdPLYzbH7eq8qPzWFPh7Aubzbkuadj/IE/d+7iKHNjxrgEqoufQMECQup7CrINoshh2HspULH7YZLlU2O58eLCt6iZrmlEa2aR1KT4qM9Lc7dGkXAWb44AN+pqjzd8HLVoIFAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHVcuvZaLMQpMITR62hey3I3VPaJ7GTq1ZbAno4xFVjcIFP+8JsjDUsLTwe5I26O51g8ku3kPCG3GARrAmiBWBxvL6ym3i2jhYNJRA1OoaHxL4aqMkLVaSVO01BsPs8xLfpWYQnMEr47C+r0zPtRRM0nArPmA+DXG3PuqFv69ctXyG8coA7z2CTfTGNfiYx2rkAdUPys1JArCIsu5xMVxjfniFEr1/eCrD7ZIm0f8QsaddGQ7Q26hvNx0b+1Hhd6k6R8e0iwjar+t+czwBkILrKwMCcuqslnQqrudbeUwyFiT2fLwjfcsyaTYJl4KDVCb/5DBmtlGlRhIJsuNT+RyeU=
ae6f21f1-8e12-46cc-b070-4e2efefb542d	c940195a-43e7-49c6-95c9-e5b5ee23f1af	privateKey	MIIEpAIBAAKCAQEAkln7X0O7QSbI1/TTeYGidIbrvyKt+UVVaik8m5egZP6HKeVUZupMMCYV9vcgXbMiyYfuSOmTzMmCb6R9mxpsbaxeiR4KWIQFdop3nvY/GqAOEHS3CrulSK6mFKL2In5CeCmeyZLDZvjzeRKtAeAJV7V7a4rPp679oMNcO1xzzTjwWbvGDF8ag0KFvUh2vctRTcybNA74e26kLSM1qMHTy2M2x+3qvKj81hT4ewLm825LmnY/yBP3fu4ihzY8a4BKqLn0DBAkLqewqyDaLIYdh7KVCx+2GS5VNjufHiwreoma5pRGtmkdSk+KjPS3O3RpFwFm+OADfqao83fBy1aCBQIDAQABAoIBABbIiFAH0M5vNcQc2pEnY72FRY0PXosYRphMzCEixTcDwtH8YBvXbL3wJ+o3BaRgn1FFZoyWREqUskgkEOPFBM08EMmC0jR+dQVDwCSQjDleYmIgcWBr3urGOZer2Op8wmdHf288+Et/BRQ7mpBYqsurNogC55ngrZ5J24FoPqTbdJcRjR3B+ixqqBBNlDO1KRr4sxTl7EGxpLxC9FPI+P590MtBjIOUs8gpbQHrdWsuFUpNbvtEvlzOjvXlRnmp3EeoN506V14O0xyhnfKT2Nu2aMYaSKn+Ji1oIuqgEl6SSFbu7oSWzEkAElndBpo9BJszRobVG3vV3N6jqGnSjF8CgYEAwjrH3sUNwBp0yAufjmHvYTVjQ7e6a4WVqYbvQ9url0YQHaJSdn+k9DePoGKveFbgp7KyXK3DwAd8fg/Uy0ji4++a2BOVum9zzF3v/unHy0mt8ynh4KMwZorste2Iy/tHRHuBeDBK6EEkUIFWMsQObDffXvNXlPlkZgVf65bZ0o8CgYEAwOUzQX0cyZGx9vrS/JNg3em4auEWLkxat+6p3JR1oPbrnLOudFKqJTo1+WbwjIrtGmRg4UQZJjO8RYUP9ZJdnn1KPEPnz7KgeQJ8joZb0xzaOjZgeqJFcJ5gx9+6y+P2LGJI1K71rKQwrOe3PxFyb/ACnE/dQmxIoTAL5ET/nCsCgYEAsmRMqPXyECv8cLQEQ0D+HRls54h7R0A1WrRdU8USD+nA6YbqGH5aYhgZ6aRaJ7wbsMr2+Rp7/QajOCGQP3ndMp8iaC1sywSMpfrtcAMGh1dP1lP0a19XGAenK91UVI2hQmvxWRN56WHTWcHBCvV5jbmvhkUYfvKkXPO4yugNfk8CgYEAkJY8yUXioiSXZS21oKVH4o8iMNrvKV0KUvyOTkzprvHmwdrdVUvxRV5QvtUuUeqAt1uuUqwcvcnhwapvv/8qNXZsgqfTxpd6Obpnat3DToc9/Ixt3P5tVnEg0jEdb188UyCIvwM2G2YnJjO544hMYyNgkZI7o2JPPqMpBr3Ba2kCgYAchlaBSbbGDNrEkYkQETmuJOsIeRv0qWBjnnokT7MEgy3XyuS50nzmwOODDP1L0gZCjA7x8XcaekLOzbWZ9+PuTD3gcy42ZHQCKJ+aCy4zsfuqP3y/C0ujoVx70Z+hTk9ESYFGQrgiuuarPn96VbeiHEFUaYKc5+y/K+CFRTe44A==
b576dd1a-8f07-4200-a6d9-7b409cf90388	c940195a-43e7-49c6-95c9-e5b5ee23f1af	priority	100
a79be75e-f2fe-46e6-9ede-b956abc831f2	fb09905f-2e5a-4fd8-8f1a-5d32685947bc	priority	100
6657849e-2244-4180-ad3c-6f53d508725c	fb09905f-2e5a-4fd8-8f1a-5d32685947bc	kid	990d7615-b029-4697-9865-6c2799a341f4
cf6031e6-5fe9-4779-8ab1-de06bf15481b	fb09905f-2e5a-4fd8-8f1a-5d32685947bc	secret	dOBCC4SwBPqvW1Krbc-4vseTQfQGeOdrvc6gY2dLJl6HQNQHYz5PXog0BQII2uQw-18PWkyMGKH7HgPpaZ5JqdrsWn0rspgkt6KJ_vaBwFmZinTaWugu-O_lpyWuCdv9M9_I7JFTXEUKcfMjqV6M5BmDY9D_TwmXlapj9Tj1cPg
e128aa57-84a1-4585-8d4f-82988bbb8eb2	fb09905f-2e5a-4fd8-8f1a-5d32685947bc	algorithm	HS512
c26b3783-6e1c-4933-a8fe-67d313856347	d0a7ef06-f3a7-41d7-b945-e2aa6eba2e7c	algorithm	RSA-OAEP
df0cae58-4074-4405-9d9f-3a513d77c3ef	d0a7ef06-f3a7-41d7-b945-e2aa6eba2e7c	privateKey	MIIEowIBAAKCAQEAzlBmMweQS8RVzg4fuW0x2LBBKismuLlv8UT1eWM8n+fNtwvspbWfMAduK+DI1nSWECerFFpzG1SV7o0DlVwnzYUESVwNpXVllhVXqwBmhJNfYbwf2HUSA5easHwL9hdXTgg+5x0U3dedGy8+5Z13DfvQlvD5k51z58q5dQPn8aXsh186eVNMxxYDGzMI/FoanYCfKv7Gmlh2JQRyFrO2Wd6FfHMVvLYz9tet/IyqR9q1uH5erzQEaNMarcLA52xr6yPZ3NDu+STFQ4G9RNVD+nuB2m0lp2s3SouUGRSIHpcFBJdh56p1bGjFDKE3yZm0M7AXV7bozoUhpp9dhAAtKwIDAQABAoIBAEmAMyiy5SFZDQif14WD9WIxSMXxIZZl2g+mdZ2NUSfWuV8hDGnszo2Z2BIhvutIFb4jo7tYjfGKrO+TpVcswbFiViicdvAfZtWVPOpa9ir9Jdn335CKBKTq+d0uFETUA/J01ZQYtDpkekAZENtUwfllYOalawS/728AthmODq/zvM2uT9k0EZd3/fSuWMj6aWNWiGMByDhEDVsugBIPanjnlQb+d7L9oJBQH2ZG36tsGoBUVFoO5SbOJkMDTvg4iVUlxBpJZxugI+UleHutxihguJmPzQsc21EEsWoNdrxEOhggqo6Z1ffe6CCV1fwrhR4basKh1zKTtVLiw2mepcECgYEA84k//mW+OQYievXYRQTvDXYDRVQ4RqV0plf+Ggikg7MWtYsEJ1cGMPba4yJnNNDeT8OsLXd/ox10oCt6WCrLpz99B//G0GAqRET3zq1mJwWT2XbwQpkOv6JGV4fiqMK89MymB9VWoQyfLXg8ywAkFuS19qUBWW1k1D+KchekIOMCgYEA2N95kNDUxbwyfxqP585U9vyY5ZkWSUlyBqHIP8BZLkMcvowJ8LSpWaRyr615S1X2loCnVdtY/QQbc5xGBOCCZsBzRdLkTGsF//5N9cWMTXCvVUvYChoM7QuFdkxZjjPG3xfwnuSfeoiykQzkmBjIReGiAdfk818TrBuZ1BYn3RkCgYB+DP8bbIvttfgozpCXALu+quN8gd/y6PaclpTF4s1MAWjypDaNKiThORQIVik3FBjNDklS6zQcOEXCFV7ovZXVRi4v8rpz5iJaXZwp1GQ4NFHXUBGBVvlkRNjFu2ac1Na6miYhjdGd4AuPnFlS9Qq48r4gID23jMCQfybocMYZ4wKBgQC2Ro18A6jxUI34ejC9GZQbyo4PWy16BzrJDCysOFQ8J7f/BuBL6Ov1Jdwmf1zUzrlkIVmDNcqDTXJtJslKzA+NoO7BntC20bTHRcvsZ07Wv4D95bL8OozmpqpTlTQn6qiZVRut0GWhrUa31uhCVYHuCggKGJSbYCu+mawer0ht8QKBgCm0ouxraHWowhb/A2DVW5v/kyFfIqly7UjdGN4LZKcqK6JzlMkwj/IO4BVyT20IlcjZBErw6ifNMlEAkoqFINB+aQjkEonAoYT9IYSosK80U6PWuh0mX/IikjNQPgFYm97Kemu11YN2Fkj3bpgD+tc2QC0vTQ9khoeU85JX3pcc
229fa17f-52e7-4177-987c-8a0e97445925	d0a7ef06-f3a7-41d7-b945-e2aa6eba2e7c	keyUse	ENC
22f75d6c-6505-40ee-9ce9-f4413f258dd6	d0a7ef06-f3a7-41d7-b945-e2aa6eba2e7c	priority	100
a07045cd-199a-45af-9f28-a0bf7b82f10d	d0a7ef06-f3a7-41d7-b945-e2aa6eba2e7c	certificate	MIICnzCCAYcCBgGUtNB1izANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhoYWNrYXRvbjAeFw0yNTAxMzAwMTI0MDhaFw0zNTAxMzAwMTI1NDhaMBMxETAPBgNVBAMMCGhhY2thdG9uMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzlBmMweQS8RVzg4fuW0x2LBBKismuLlv8UT1eWM8n+fNtwvspbWfMAduK+DI1nSWECerFFpzG1SV7o0DlVwnzYUESVwNpXVllhVXqwBmhJNfYbwf2HUSA5easHwL9hdXTgg+5x0U3dedGy8+5Z13DfvQlvD5k51z58q5dQPn8aXsh186eVNMxxYDGzMI/FoanYCfKv7Gmlh2JQRyFrO2Wd6FfHMVvLYz9tet/IyqR9q1uH5erzQEaNMarcLA52xr6yPZ3NDu+STFQ4G9RNVD+nuB2m0lp2s3SouUGRSIHpcFBJdh56p1bGjFDKE3yZm0M7AXV7bozoUhpp9dhAAtKwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQB7r21fT3Ed/eOuO0a45FnjRhdAXshwkDGf5DH5Kzbmj/FJoPEksmYbr6V4AWIbA/qu4qQ1keps2dZ/zgbLqh5kzgm0frnY4xmvrs5kQvdSWTtworXLG0hYirbCXTQrBW7MyT5Mp21CgF98f4dHzTKx48+GQggsRWF7h9hRQCMkFxl8K1cPjuB4tmBEBd6vr+sEuF/5ZEV4XtKCEuDdUtHXKVMq7sCGGGQU5jmLKeMWm7JHzZNH/dlkwAcyZ362BaoIbC7gBY8lA9LJdApCfI2q30Fy4PyStwzhBnyc2teZ9xgS5kMz87VO+9qYaI1/gfoi5YTuoMaCBLGtgm/cxYgF
004c74eb-d713-4f16-9071-4987a20d2c5c	3af89921-dcf4-49ad-8a9d-6565f1558ae9	priority	100
b07db3af-d2d8-4ae4-8a50-2a80dee28b83	3af89921-dcf4-49ad-8a9d-6565f1558ae9	privateKey	MIIEogIBAAKCAQEA0u/tHv/a70vNwU3OHeadr6938uDhuGe1BUqwBLn1pnH3Z9XmcTO2KsMIXfJI4a0kkueTAi86DXQhaUr3+kQSbvYfHgN8UQSFu/N89gmBo15hhPpFvzvZvCGVnHM7hTVfL0wLMvQ0Q42AAnVlDu8Eupl6Iz6yZiLN/BKbNIxbwe7EnTFU4b7H1/lhx7pF+6KKpAK85qCyMmVpZq/DH3Zx9zXJGSTFq54veeHyy5DeE4+QihZPKo6fDwGNIBrsYEi7MCeRdjQAegRxaHKDXJ1+hVqj4NxIN62SLYTXZQj3xAGgF+NBpY4+chAZAEyvoNcXLGqDPYf12FMl2BihyVmdQwIDAQABAoIBAAEmW5Af3QBGPBQV45+dLAgbyUHZWepIznwIAmJ2gomKi/hGoLK02YI1axLfbjS5Rr3KhC+jqUP3RINtO5afrJDglzd3Ks/9B26KAi899stRspz/4b/CnfZOU8GiABH/N95Iv9/1jBpOa3MYt4skluaaBuWd7k6w4M9R4ctoVdGHNksbZ5tQ9ey6jlM+IZ+E7OWwW6uWHeK9PpPRkGY58izqNRi//OkPYC2Cy6dw7ZdYEk22FAaPIIpmS2IjbUcfl0hrrJ0WzgbGtkh8hro8rQM5y7B5DCml6A2QWvVLmsSJJSzyfypNVxO9yH5hJXsoGUsPfu9pYgUc41oIDJ6jdbUCgYEA6ofQs/giC2odsw++0iihpR4IbRu8g7sriRjaob42Pw+9DxT+xgBT1HNBroHR9xTznT/JsqbXcJJOZZRHaT5ZwVqH+2ygpV/zZ8686gUgTsV1C0OzDBaGSmKEH1hIofPCx2JcHWfKaMppUcX2FErZO0ZlxGbRuyp8B5m4b4TXQMcCgYEA5j80mkz/RH/MkhzjUgYyXkYDnfpQcqlaEZ8KHPZ8lAHY1QWZZzcMEoaKR7fJVvmQHZWyLlqBTdZc7peneBBBxKNKegiPJo444psV5rrvDG1Xlz5gbB3Cgkc1JFUYKKy+/EZSC6vYI1estHjDNVvWAkICNi0a2iX1uOMiiyrZO6UCgYAF9kHl8U7cP2xV2vac3Q+O5P6N14CpUJ7As3MLXYx/eeTydzQq0GNRKUToLMCrqUqwGqkD853SbMW1a1mNYVpiwexnBdHnolLLtsOyp0K0/ewFx0jL696qEWsOaO4fv9SZwPRagwLwOwUGYSPqTCTNjvKTVZHLUj8o6k13+EaIjQKBgCqR4xLoS4YJrvQQ3UKsHKHrhf2uazNX9mwtoHwMYqom0UVJfLxlpBjEwUpTQ6mOCMQ/iish1qhiitoeNftv3gkSO9HmRTlWsFPNYrY/N7VvffNbuA4lTnIx4jRue0IB9mnEQqUfx515N1hCv6zc5uuR8sC7hCxzOkRN0nQynul1AoGAKyoyZ18OvemJoXKJFvqCLk26HRraHejPsImYGygU2hON/8n37CojCtoks6WT/Gw0EsRS5oa90qfMZV9ZrWav+vlgslJtZbv+SqSvkQPtjqMGGpgH2LvtTmL8bb5ezE1OGZuXHeXds6O1csOuwHBjBDkS70iZO4lyVNVdVepBq80=
0c6e1590-e7c6-4c55-942f-c3750831affa	3af89921-dcf4-49ad-8a9d-6565f1558ae9	keyUse	SIG
2727b551-09a4-4d84-a024-28848ef57f6f	3af89921-dcf4-49ad-8a9d-6565f1558ae9	certificate	MIICnzCCAYcCBgGUtNB1VDANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhoYWNrYXRvbjAeFw0yNTAxMzAwMTI0MDdaFw0zNTAxMzAwMTI1NDdaMBMxETAPBgNVBAMMCGhhY2thdG9uMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0u/tHv/a70vNwU3OHeadr6938uDhuGe1BUqwBLn1pnH3Z9XmcTO2KsMIXfJI4a0kkueTAi86DXQhaUr3+kQSbvYfHgN8UQSFu/N89gmBo15hhPpFvzvZvCGVnHM7hTVfL0wLMvQ0Q42AAnVlDu8Eupl6Iz6yZiLN/BKbNIxbwe7EnTFU4b7H1/lhx7pF+6KKpAK85qCyMmVpZq/DH3Zx9zXJGSTFq54veeHyy5DeE4+QihZPKo6fDwGNIBrsYEi7MCeRdjQAegRxaHKDXJ1+hVqj4NxIN62SLYTXZQj3xAGgF+NBpY4+chAZAEyvoNcXLGqDPYf12FMl2BihyVmdQwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAgQZMHJi0gLV84i2Hgn2fTVRmFloA9VXz5c+V0ljwxVmd8tGr99ihNMNAYGAYTCjk51ComUPQXk1VBc5UmI1+B+x++NrGNRixfL1BK+DrsBhv/024FHMPYJrOBeWrcTb9ni+pbxv69ycrcOmRPupow5F5lGyRVwsypgb2gu/w93m61gG86/Yw729MG9INs08dVvjvHCwFa31xV1+SKBX4R+rV/NbEg9o8DKQaktzDhUcNkItSiA8y5aDfy1PDU9frhpnU849Upy5GUmpdxjJfHdJyCgstHjFQkVf8HzaG1wTET31EahpCBEfXrxPrvsn20eOKAFEneNHo6yXgLXLEn
95d31e0c-2288-477d-b9f6-e7b31770ba83	e96ad033-0f02-4592-80c8-f6a2902c7768	kid	dfb3fbed-65de-465b-b147-fbe07ef804f8
8257cf0c-2dfb-434e-b30f-665522c1fcb0	e96ad033-0f02-4592-80c8-f6a2902c7768	priority	100
7f36cbd5-e1a0-4d3f-8ec9-fdf4aa12b3d6	e96ad033-0f02-4592-80c8-f6a2902c7768	secret	F0e1kIQj6DiR8r9-CqOOiQ
58c18d9f-d71f-49a4-a03c-7375d67bcab6	95d0fb1f-7cc5-48fb-b257-3762e0b6eacb	allow-default-scopes	true
d33f18dc-7f3e-4417-8551-fd22f377bcff	e903c19a-a338-410b-bc85-d99abad73baa	allowed-protocol-mapper-types	saml-user-property-mapper
52032c41-cd46-4ce0-852c-99c3bc0c66b2	e903c19a-a338-410b-bc85-d99abad73baa	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3f7f50bf-5fea-484c-82a9-846860bde62d	e903c19a-a338-410b-bc85-d99abad73baa	allowed-protocol-mapper-types	oidc-full-name-mapper
d504e874-76e2-4fd4-9fbf-fe348528ba5b	e903c19a-a338-410b-bc85-d99abad73baa	allowed-protocol-mapper-types	oidc-address-mapper
b27ca169-ffe2-45c8-908e-4d94b8b86cc4	e903c19a-a338-410b-bc85-d99abad73baa	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
25cb0382-a015-42e8-88f2-507a356ceba3	e903c19a-a338-410b-bc85-d99abad73baa	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7ece9354-6147-46f6-9d1c-0e6665c38012	e903c19a-a338-410b-bc85-d99abad73baa	allowed-protocol-mapper-types	saml-user-attribute-mapper
8ec90d66-1507-468a-97d4-68a6cad959b2	e903c19a-a338-410b-bc85-d99abad73baa	allowed-protocol-mapper-types	saml-role-list-mapper
7d1a0c58-056c-439d-823f-655feff4de09	47122e7d-c283-442d-ab94-33bbf8fe3d12	host-sending-registration-request-must-match	true
f3c0d85e-6fb7-41f4-9dd2-1d3671545dad	47122e7d-c283-442d-ab94-33bbf8fe3d12	client-uris-must-match	true
928a2a19-abb7-44b6-a956-868092464868	1038c1d1-9b32-4b6b-986f-2ae715a9d8a9	allowed-protocol-mapper-types	oidc-address-mapper
0927457a-4906-47f0-a635-75e22eb1c8b3	1038c1d1-9b32-4b6b-986f-2ae715a9d8a9	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b34f330a-29a9-4204-afe1-fff100962512	1038c1d1-9b32-4b6b-986f-2ae715a9d8a9	allowed-protocol-mapper-types	oidc-full-name-mapper
d0cb6819-ad24-4aef-a57d-bb5dea8f439e	1038c1d1-9b32-4b6b-986f-2ae715a9d8a9	allowed-protocol-mapper-types	saml-role-list-mapper
ec55b76a-7545-46af-9272-a67a26d9b11b	1038c1d1-9b32-4b6b-986f-2ae715a9d8a9	allowed-protocol-mapper-types	saml-user-property-mapper
eb76a83e-0c34-4ef2-84df-bfccfeaba6c2	1038c1d1-9b32-4b6b-986f-2ae715a9d8a9	allowed-protocol-mapper-types	saml-user-attribute-mapper
8f3e57b3-4d3e-4ca3-8ef9-064ce60fbb5d	1038c1d1-9b32-4b6b-986f-2ae715a9d8a9	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1e73d957-9ce2-4f6c-bbe8-70ea21ddb36b	1038c1d1-9b32-4b6b-986f-2ae715a9d8a9	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
172e1e75-f85b-4ec0-bfde-6aa348a78119	d00f33a4-cfc2-4cbe-a184-a5d8ed600f09	allow-default-scopes	true
a0a24275-430e-4ca2-bae1-2273af598992	2c051b49-b1d1-403e-af4f-c9948dd373d7	max-clients	200
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
17525f97-5bd5-4888-a665-d03406f2f16d	36d96cd5-ae81-4a40-ab8f-fbac8b7eddc5
17525f97-5bd5-4888-a665-d03406f2f16d	93d7202a-9cf5-4b34-8846-8b3fe0ab2540
17525f97-5bd5-4888-a665-d03406f2f16d	66cbb382-7ab7-4655-8edc-5662fdd6bc51
17525f97-5bd5-4888-a665-d03406f2f16d	5e48832f-ca4d-4030-85d5-f3000b15fcf0
17525f97-5bd5-4888-a665-d03406f2f16d	e7b9b28d-48db-47aa-97cd-9d99465ce3e3
17525f97-5bd5-4888-a665-d03406f2f16d	a1ddb301-00ae-4ca5-8615-5f55ba1fb3ee
17525f97-5bd5-4888-a665-d03406f2f16d	ce95875d-bab1-4d66-b97a-1238f5a516af
17525f97-5bd5-4888-a665-d03406f2f16d	3849b4b9-836c-4cc8-805e-5391216b4651
17525f97-5bd5-4888-a665-d03406f2f16d	1e6252e4-b069-4066-b0ef-83322834931a
17525f97-5bd5-4888-a665-d03406f2f16d	a4287f06-95c0-475e-8938-36b420e7010a
17525f97-5bd5-4888-a665-d03406f2f16d	a68fc3f6-2462-46db-8057-4b5199edcf21
17525f97-5bd5-4888-a665-d03406f2f16d	9e7b87c1-50a4-412b-84a7-1dc3a7395059
17525f97-5bd5-4888-a665-d03406f2f16d	18febeb1-f73a-4d00-b058-2d990b151120
17525f97-5bd5-4888-a665-d03406f2f16d	171853e0-7626-4afe-a5f5-0f5f4cfdf3aa
17525f97-5bd5-4888-a665-d03406f2f16d	953cc837-e7d9-4318-8066-60d1b8a8e096
17525f97-5bd5-4888-a665-d03406f2f16d	ea3a4140-629e-4dfa-9b9b-1281e78e3f62
17525f97-5bd5-4888-a665-d03406f2f16d	16fed19b-2808-4a0f-bb81-a2f343d30c84
17525f97-5bd5-4888-a665-d03406f2f16d	b8c5b896-c2f1-4eb4-9727-075973f1a739
5e48832f-ca4d-4030-85d5-f3000b15fcf0	b8c5b896-c2f1-4eb4-9727-075973f1a739
5e48832f-ca4d-4030-85d5-f3000b15fcf0	953cc837-e7d9-4318-8066-60d1b8a8e096
bccaa811-7558-4ba0-b883-1987bb1e4314	a9da7df1-ba3c-4377-b7ea-459a5a9f92ad
e7b9b28d-48db-47aa-97cd-9d99465ce3e3	ea3a4140-629e-4dfa-9b9b-1281e78e3f62
bccaa811-7558-4ba0-b883-1987bb1e4314	3d0379f3-17a4-444a-af80-fa58caaa48b0
3d0379f3-17a4-444a-af80-fa58caaa48b0	8352c140-ba07-4ffa-b21e-088b94d05dc9
7c96c46f-9a5d-4638-8d97-ce1c0434a1a6	55ea11f3-836e-4c73-95e5-fcde3d312ad9
17525f97-5bd5-4888-a665-d03406f2f16d	1fec897d-1293-49d1-b3e6-eaac33b586b7
bccaa811-7558-4ba0-b883-1987bb1e4314	5054ac72-e29a-4243-bc4f-a5e714152309
bccaa811-7558-4ba0-b883-1987bb1e4314	472d746b-a8e5-4ccc-bfea-f37628d3de95
17525f97-5bd5-4888-a665-d03406f2f16d	425a34e6-b753-45db-8cb8-5aff279a3d83
17525f97-5bd5-4888-a665-d03406f2f16d	c93d4cda-7482-4c27-9939-1695bd6109b6
17525f97-5bd5-4888-a665-d03406f2f16d	50e0f121-ffaf-47b9-9577-b2f0f39517aa
17525f97-5bd5-4888-a665-d03406f2f16d	ab186bb8-d3ff-41ba-ada9-65a80ba391b8
17525f97-5bd5-4888-a665-d03406f2f16d	3a3d7abb-9b48-4ac4-8ac9-53cecc241a43
17525f97-5bd5-4888-a665-d03406f2f16d	f1831017-5beb-4df5-952e-0f3cce5c3bb3
17525f97-5bd5-4888-a665-d03406f2f16d	e33d7875-8535-46ea-9ea4-c6b54a3334d7
17525f97-5bd5-4888-a665-d03406f2f16d	2fefbb1c-9265-4ff0-83d7-826ff9b6bf8c
17525f97-5bd5-4888-a665-d03406f2f16d	9958df72-5b7c-4cbb-a6cf-c72ba6172f75
17525f97-5bd5-4888-a665-d03406f2f16d	7c6b40b9-753c-4b5c-bde2-75d58984d6bc
17525f97-5bd5-4888-a665-d03406f2f16d	102b3a62-d86d-41ea-addc-9c7d53df8fd5
17525f97-5bd5-4888-a665-d03406f2f16d	9ae14ee6-8f27-4aae-93f8-689db2866a0f
17525f97-5bd5-4888-a665-d03406f2f16d	bc330cc8-e210-4bbf-a5f4-ab17768523fd
17525f97-5bd5-4888-a665-d03406f2f16d	eca6d41c-a5e3-4987-9e73-895d5a7c5d28
17525f97-5bd5-4888-a665-d03406f2f16d	e7851c36-4333-42c1-be3c-36b6674b6cb0
17525f97-5bd5-4888-a665-d03406f2f16d	da8bc897-8fe2-43dd-84cc-9299ffd3955f
17525f97-5bd5-4888-a665-d03406f2f16d	23b2ca2f-3292-44cc-9135-eda3dd675d86
50e0f121-ffaf-47b9-9577-b2f0f39517aa	eca6d41c-a5e3-4987-9e73-895d5a7c5d28
50e0f121-ffaf-47b9-9577-b2f0f39517aa	23b2ca2f-3292-44cc-9135-eda3dd675d86
ab186bb8-d3ff-41ba-ada9-65a80ba391b8	e7851c36-4333-42c1-be3c-36b6674b6cb0
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	44d56347-f949-43ba-8d75-4b5076238651
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	fbef3d23-579b-40d4-b45c-adfe0db7a666
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	7fc420b7-dcc5-46be-a0e9-4a4591ddaccb
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	f015c524-c84e-4771-9561-8617233851a7
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	9002b052-aacc-4e90-8299-99a85ae3b419
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	eef4a17b-f018-4091-92dc-a9f2e8a9fb16
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	8200d8b4-f015-4147-bac6-25fc7d181aa7
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	29f51dc1-8da0-4d18-a566-8da7d32e5120
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	377fd5fe-7691-4f7c-b352-bc2ac332fe79
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	45a8b1cb-1733-4a69-bd9f-84b8804c0c0f
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	cee80322-c935-4164-ad44-5f0761ab2b53
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	9cdd04d1-48ae-4e39-8a1c-e5d747900761
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	983de620-d6ac-4fc7-820a-e184d3779c1e
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	100f0d47-7e3c-4512-89ae-ec5e9e838400
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	d6f13609-0084-4121-bd8a-c2714064ba58
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	a4c4e904-caaf-4732-879b-765f9824db16
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	ba248ea5-1730-4dd9-8c9e-05e9f84421f2
7fc420b7-dcc5-46be-a0e9-4a4591ddaccb	100f0d47-7e3c-4512-89ae-ec5e9e838400
7fc420b7-dcc5-46be-a0e9-4a4591ddaccb	ba248ea5-1730-4dd9-8c9e-05e9f84421f2
f015c524-c84e-4771-9561-8617233851a7	d6f13609-0084-4121-bd8a-c2714064ba58
ffda1a5e-2918-4a71-9003-a340361d99eb	b0d63051-4293-452b-aa17-0e726abbe01b
ffda1a5e-2918-4a71-9003-a340361d99eb	a68d2d30-2838-4565-b05c-88dd2f5f29e2
a68d2d30-2838-4565-b05c-88dd2f5f29e2	a8d30b6f-d412-43ae-af54-f3ba1796b5bb
2a2edc5f-5400-4612-a419-cc888e5b8e49	df42e096-50a8-4550-95c6-ab86456b5d44
17525f97-5bd5-4888-a665-d03406f2f16d	c1d23e8a-f380-456a-9756-968ac0f95ed8
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	121f836f-d875-4434-98de-3ebd6b63e332
ffda1a5e-2918-4a71-9003-a340361d99eb	b0eea1cd-408b-48ba-b6be-9ab967d7a1db
ffda1a5e-2918-4a71-9003-a340361d99eb	4aac7569-4b97-433e-8442-1ae5405ba405
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
7ebb5e3e-e1d2-4ad5-baa2-df402e700464	\N	password	45b1f57d-e7f7-4a1d-8243-f16b764ce165	1738200319645	\N	{"value":"jHarg93zhYHuVjtE6h/cl5BE1nxPEP1OA/2ZErXMI+8=","salt":"myNVOo+UqKubpfmD2vlZDw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
893fc8e5-372f-4e16-b15b-5d270caeeb2e	\N	password	ff9ca1bc-849a-48cb-8236-77986d6434ba	1738200371508	My password	{"value":"INfVP+f3hpG8QSkFf/s0DXp+lNVxqm3p9afTFYYdTiM=","salt":"plWpuBF79jbLg9aQwzzNvA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-01-30 01:25:08.415648	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	8200307971
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-01-30 01:25:08.432455	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	8200307971
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-01-30 01:25:08.479936	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	8200307971
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-01-30 01:25:08.484163	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8200307971
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-01-30 01:25:08.581326	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	8200307971
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-01-30 01:25:08.587282	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	8200307971
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-01-30 01:25:08.680868	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	8200307971
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-01-30 01:25:08.685647	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	8200307971
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-01-30 01:25:08.692091	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	8200307971
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-01-30 01:25:08.786221	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	8200307971
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-01-30 01:25:08.847897	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8200307971
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-01-30 01:25:08.853982	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8200307971
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-01-30 01:25:08.880049	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8200307971
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-01-30 01:25:08.901878	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	8200307971
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-01-30 01:25:08.903817	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8200307971
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-01-30 01:25:08.906923	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	8200307971
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-01-30 01:25:08.909935	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	8200307971
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-01-30 01:25:08.962713	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	8200307971
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-01-30 01:25:09.014799	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	8200307971
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-01-30 01:25:09.02022	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	8200307971
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-01-30 01:25:09.023693	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	8200307971
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-01-30 01:25:09.026591	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	8200307971
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-01-30 01:25:09.119065	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	8200307971
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-01-30 01:25:09.12518	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	8200307971
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-01-30 01:25:09.12669	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	8200307971
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-01-30 01:25:09.56983	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	8200307971
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-01-30 01:25:09.637917	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	8200307971
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-01-30 01:25:09.641587	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	8200307971
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-01-30 01:25:09.696185	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	8200307971
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-01-30 01:25:09.710256	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	8200307971
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-01-30 01:25:09.728371	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	8200307971
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-01-30 01:25:09.733606	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	8200307971
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-01-30 01:25:09.73922	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8200307971
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-01-30 01:25:09.741526	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	8200307971
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-01-30 01:25:09.773179	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	8200307971
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-01-30 01:25:09.781928	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	8200307971
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-01-30 01:25:09.791787	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8200307971
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-01-30 01:25:09.795839	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	8200307971
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-01-30 01:25:09.799115	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	8200307971
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-01-30 01:25:09.800286	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	8200307971
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-01-30 01:25:09.802025	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	8200307971
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-01-30 01:25:09.806459	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	8200307971
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-01-30 01:25:11.536877	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	8200307971
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-01-30 01:25:11.539722	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	8200307971
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-01-30 01:25:11.546168	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	8200307971
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-01-30 01:25:11.549408	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	8200307971
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-01-30 01:25:11.550281	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	8200307971
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-01-30 01:25:11.674122	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	8200307971
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-01-30 01:25:11.676521	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	8200307971
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-01-30 01:25:11.701664	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	8200307971
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-01-30 01:25:12.048921	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	8200307971
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-01-30 01:25:12.051847	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8200307971
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-01-30 01:25:12.053632	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	8200307971
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-01-30 01:25:12.055119	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	8200307971
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-01-30 01:25:12.058583	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	8200307971
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-01-30 01:25:12.062206	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	8200307971
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-01-30 01:25:12.104027	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	8200307971
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-01-30 01:25:12.503956	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	8200307971
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-01-30 01:25:12.521963	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	8200307971
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-01-30 01:25:12.525563	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	8200307971
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-01-30 01:25:12.530654	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	8200307971
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-01-30 01:25:12.533738	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	8200307971
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-01-30 01:25:12.537881	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	8200307971
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-01-30 01:25:12.539613	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	8200307971
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-01-30 01:25:12.541319	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	8200307971
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-01-30 01:25:12.580334	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	8200307971
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-01-30 01:25:12.617477	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	8200307971
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-01-30 01:25:12.620186	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	8200307971
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-01-30 01:25:12.658055	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	8200307971
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-01-30 01:25:12.664107	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	8200307971
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-01-30 01:25:12.666453	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	8200307971
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-01-30 01:25:12.670544	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8200307971
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-01-30 01:25:12.677626	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8200307971
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-01-30 01:25:12.678837	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8200307971
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-01-30 01:25:12.696134	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	8200307971
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-01-30 01:25:12.736037	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	8200307971
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-01-30 01:25:12.738853	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	8200307971
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-01-30 01:25:12.739841	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	8200307971
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-01-30 01:25:12.754863	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	8200307971
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-01-30 01:25:12.757364	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	8200307971
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-01-30 01:25:12.796342	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	8200307971
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-01-30 01:25:12.797664	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8200307971
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-01-30 01:25:12.8028	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8200307971
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-01-30 01:25:12.803615	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8200307971
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-01-30 01:25:12.851545	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8200307971
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-01-30 01:25:12.855821	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	8200307971
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-01-30 01:25:12.864124	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	8200307971
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-01-30 01:25:12.870419	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	8200307971
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-01-30 01:25:12.878869	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	8200307971
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-01-30 01:25:12.885651	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	8200307971
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-01-30 01:25:12.930211	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8200307971
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-01-30 01:25:12.941368	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	8200307971
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-01-30 01:25:12.942345	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	8200307971
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-01-30 01:25:12.948995	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	8200307971
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-01-30 01:25:12.950154	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	8200307971
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-01-30 01:25:12.957805	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	8200307971
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-01-30 01:25:13.068586	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8200307971
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-01-30 01:25:13.069755	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8200307971
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-01-30 01:25:13.079712	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8200307971
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-01-30 01:25:13.121583	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8200307971
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-01-30 01:25:13.123043	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8200307971
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-01-30 01:25:13.249084	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	8200307971
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-01-30 01:25:13.25668	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	8200307971
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-01-30 01:25:13.267483	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	8200307971
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-01-30 01:25:13.341171	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	8200307971
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-01-30 01:25:13.410567	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	8200307971
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-01-30 01:25:13.491844	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	8200307971
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-01-30 01:25:13.498666	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	8200307971
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-01-30 01:25:13.571695	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	8200307971
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-01-30 01:25:13.574649	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	8200307971
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-01-30 01:25:13.585244	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8200307971
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-01-30 01:25:13.592068	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	8200307971
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-01-30 01:25:13.623367	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	8200307971
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-01-30 01:25:13.631791	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	8200307971
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-01-30 01:25:13.638872	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	8200307971
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-01-30 01:25:13.640589	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	8200307971
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-01-30 01:25:13.647855	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	8200307971
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-01-30 01:25:13.651343	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8200307971
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-01-30 01:25:13.88443	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	8200307971
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-01-30 01:25:13.892105	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	8200307971
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-01-30 01:25:13.89822	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8200307971
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-01-30 01:25:13.956714	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8200307971
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-01-30 01:25:13.961083	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	8200307971
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-01-30 01:25:13.962416	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8200307971
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-01-30 01:25:13.964	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8200307971
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:13.968629	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8200307971
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.01955	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8200307971
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.081778	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8200307971
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.133808	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8200307971
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.181614	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8200307971
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.234774	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8200307971
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.236378	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8200307971
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.288259	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8200307971
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.304236	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	8200307971
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.314319	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	8200307971
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.315644	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	8200307971
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-01-30 01:25:14.407724	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	8200307971
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-01-30 01:25:14.41486	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	8200307971
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-01-30 01:25:14.421089	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	8200307971
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-01-30 01:25:14.469221	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	8200307971
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-01-30 01:25:14.475957	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	8200307971
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-01-30 01:25:14.48112	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	8200307971
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-01-30 01:25:14.525182	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	8200307971
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-01-30 01:25:14.604914	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	8200307971
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-01-30 01:25:14.6465	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8200307971
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-01-30 01:25:14.661402	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	8200307971
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-01-30 01:25:14.663991	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	8200307971
26.0.6-34013	keycloak	META-INF/jpa-changelog-26.0.6.xml	2025-01-30 01:25:14.666142	148	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	8200307971
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
f3481901-3ac1-43bb-b067-1ac965a8d282	1c0cd907-f413-41ad-a99e-e5716cfbdf49	f
f3481901-3ac1-43bb-b067-1ac965a8d282	1c29c3e9-540e-43c8-a428-fd7fad46c123	t
f3481901-3ac1-43bb-b067-1ac965a8d282	2e44bf17-d2ed-4361-aa01-1ec0d6dbf995	t
f3481901-3ac1-43bb-b067-1ac965a8d282	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612	t
f3481901-3ac1-43bb-b067-1ac965a8d282	4b02e0ab-5c9b-4363-ba7e-8821c22ce76b	t
f3481901-3ac1-43bb-b067-1ac965a8d282	a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e	f
f3481901-3ac1-43bb-b067-1ac965a8d282	2baec8d4-9279-4cc3-812d-26a55ce86a19	f
f3481901-3ac1-43bb-b067-1ac965a8d282	731c0c0a-78b4-4a73-93ee-60ac219ddb7e	t
f3481901-3ac1-43bb-b067-1ac965a8d282	d1378567-9a9b-4b5a-bca2-d5913c6abe4b	t
f3481901-3ac1-43bb-b067-1ac965a8d282	c017baf6-10d4-4df8-97a2-fd2cb7ba59c0	f
f3481901-3ac1-43bb-b067-1ac965a8d282	4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5	t
f3481901-3ac1-43bb-b067-1ac965a8d282	8a6d7158-e3d7-4b35-96e3-0c18e9e0a663	t
f3481901-3ac1-43bb-b067-1ac965a8d282	9d684b80-7dfa-462c-bd69-01f018106004	f
503310e2-70f4-445d-bfe0-0c00deb5ea32	283e2fb0-c8ef-4894-98b8-c39c13921fe8	f
503310e2-70f4-445d-bfe0-0c00deb5ea32	47065527-0797-4d89-a387-3ced372d8c61	t
503310e2-70f4-445d-bfe0-0c00deb5ea32	a94aff13-c1a7-4c99-82ad-809246f11c85	t
503310e2-70f4-445d-bfe0-0c00deb5ea32	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43	t
503310e2-70f4-445d-bfe0-0c00deb5ea32	ee8e6063-f7ad-4396-a283-3a7ec8b40438	t
503310e2-70f4-445d-bfe0-0c00deb5ea32	7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5	f
503310e2-70f4-445d-bfe0-0c00deb5ea32	8f3984b6-bc11-469b-a9cc-e5226b78a886	f
503310e2-70f4-445d-bfe0-0c00deb5ea32	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb	t
503310e2-70f4-445d-bfe0-0c00deb5ea32	a1e10876-e6de-48ce-be9e-4c0147e6983d	t
503310e2-70f4-445d-bfe0-0c00deb5ea32	3519f343-cbda-441c-87a0-5042d7963e55	f
503310e2-70f4-445d-bfe0-0c00deb5ea32	6cbf8bad-0262-4b4a-91b3-507944b1f138	t
503310e2-70f4-445d-bfe0-0c00deb5ea32	47396527-458e-4dfa-a421-41e1e32561eb	t
503310e2-70f4-445d-bfe0-0c00deb5ea32	01a7bfb5-2588-426c-9176-e59c5c2351a9	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
bccaa811-7558-4ba0-b883-1987bb1e4314	f3481901-3ac1-43bb-b067-1ac965a8d282	f	${role_default-roles}	default-roles-master	f3481901-3ac1-43bb-b067-1ac965a8d282	\N	\N
17525f97-5bd5-4888-a665-d03406f2f16d	f3481901-3ac1-43bb-b067-1ac965a8d282	f	${role_admin}	admin	f3481901-3ac1-43bb-b067-1ac965a8d282	\N	\N
36d96cd5-ae81-4a40-ab8f-fbac8b7eddc5	f3481901-3ac1-43bb-b067-1ac965a8d282	f	${role_create-realm}	create-realm	f3481901-3ac1-43bb-b067-1ac965a8d282	\N	\N
93d7202a-9cf5-4b34-8846-8b3fe0ab2540	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_create-client}	create-client	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
66cbb382-7ab7-4655-8edc-5662fdd6bc51	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_view-realm}	view-realm	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
5e48832f-ca4d-4030-85d5-f3000b15fcf0	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_view-users}	view-users	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
e7b9b28d-48db-47aa-97cd-9d99465ce3e3	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_view-clients}	view-clients	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
a1ddb301-00ae-4ca5-8615-5f55ba1fb3ee	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_view-events}	view-events	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
ce95875d-bab1-4d66-b97a-1238f5a516af	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_view-identity-providers}	view-identity-providers	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
3849b4b9-836c-4cc8-805e-5391216b4651	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_view-authorization}	view-authorization	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
1e6252e4-b069-4066-b0ef-83322834931a	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_manage-realm}	manage-realm	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
a4287f06-95c0-475e-8938-36b420e7010a	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_manage-users}	manage-users	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
a68fc3f6-2462-46db-8057-4b5199edcf21	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_manage-clients}	manage-clients	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
9e7b87c1-50a4-412b-84a7-1dc3a7395059	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_manage-events}	manage-events	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
18febeb1-f73a-4d00-b058-2d990b151120	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_manage-identity-providers}	manage-identity-providers	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
171853e0-7626-4afe-a5f5-0f5f4cfdf3aa	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_manage-authorization}	manage-authorization	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
953cc837-e7d9-4318-8066-60d1b8a8e096	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_query-users}	query-users	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
ea3a4140-629e-4dfa-9b9b-1281e78e3f62	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_query-clients}	query-clients	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
16fed19b-2808-4a0f-bb81-a2f343d30c84	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_query-realms}	query-realms	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
b8c5b896-c2f1-4eb4-9727-075973f1a739	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_query-groups}	query-groups	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
a9da7df1-ba3c-4377-b7ea-459a5a9f92ad	b904d985-b7d6-4352-b9aa-42626d8ce09e	t	${role_view-profile}	view-profile	f3481901-3ac1-43bb-b067-1ac965a8d282	b904d985-b7d6-4352-b9aa-42626d8ce09e	\N
3d0379f3-17a4-444a-af80-fa58caaa48b0	b904d985-b7d6-4352-b9aa-42626d8ce09e	t	${role_manage-account}	manage-account	f3481901-3ac1-43bb-b067-1ac965a8d282	b904d985-b7d6-4352-b9aa-42626d8ce09e	\N
8352c140-ba07-4ffa-b21e-088b94d05dc9	b904d985-b7d6-4352-b9aa-42626d8ce09e	t	${role_manage-account-links}	manage-account-links	f3481901-3ac1-43bb-b067-1ac965a8d282	b904d985-b7d6-4352-b9aa-42626d8ce09e	\N
018327bf-89fd-45d3-857a-fec11bbf181a	b904d985-b7d6-4352-b9aa-42626d8ce09e	t	${role_view-applications}	view-applications	f3481901-3ac1-43bb-b067-1ac965a8d282	b904d985-b7d6-4352-b9aa-42626d8ce09e	\N
55ea11f3-836e-4c73-95e5-fcde3d312ad9	b904d985-b7d6-4352-b9aa-42626d8ce09e	t	${role_view-consent}	view-consent	f3481901-3ac1-43bb-b067-1ac965a8d282	b904d985-b7d6-4352-b9aa-42626d8ce09e	\N
7c96c46f-9a5d-4638-8d97-ce1c0434a1a6	b904d985-b7d6-4352-b9aa-42626d8ce09e	t	${role_manage-consent}	manage-consent	f3481901-3ac1-43bb-b067-1ac965a8d282	b904d985-b7d6-4352-b9aa-42626d8ce09e	\N
e11e835b-a383-4a8e-961e-bd90a40858ff	b904d985-b7d6-4352-b9aa-42626d8ce09e	t	${role_view-groups}	view-groups	f3481901-3ac1-43bb-b067-1ac965a8d282	b904d985-b7d6-4352-b9aa-42626d8ce09e	\N
67684318-31ac-4432-8f06-14b8df533cbc	b904d985-b7d6-4352-b9aa-42626d8ce09e	t	${role_delete-account}	delete-account	f3481901-3ac1-43bb-b067-1ac965a8d282	b904d985-b7d6-4352-b9aa-42626d8ce09e	\N
6dcc2bdc-5cd1-490c-b0b5-bd42af44b795	ebe6a098-26ec-4c11-b936-b291f3c3f840	t	${role_read-token}	read-token	f3481901-3ac1-43bb-b067-1ac965a8d282	ebe6a098-26ec-4c11-b936-b291f3c3f840	\N
1fec897d-1293-49d1-b3e6-eaac33b586b7	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	t	${role_impersonation}	impersonation	f3481901-3ac1-43bb-b067-1ac965a8d282	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	\N
5054ac72-e29a-4243-bc4f-a5e714152309	f3481901-3ac1-43bb-b067-1ac965a8d282	f	${role_offline-access}	offline_access	f3481901-3ac1-43bb-b067-1ac965a8d282	\N	\N
472d746b-a8e5-4ccc-bfea-f37628d3de95	f3481901-3ac1-43bb-b067-1ac965a8d282	f	${role_uma_authorization}	uma_authorization	f3481901-3ac1-43bb-b067-1ac965a8d282	\N	\N
ffda1a5e-2918-4a71-9003-a340361d99eb	503310e2-70f4-445d-bfe0-0c00deb5ea32	f	${role_default-roles}	default-roles-hackaton	503310e2-70f4-445d-bfe0-0c00deb5ea32	\N	\N
425a34e6-b753-45db-8cb8-5aff279a3d83	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_create-client}	create-client	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
c93d4cda-7482-4c27-9939-1695bd6109b6	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_view-realm}	view-realm	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
50e0f121-ffaf-47b9-9577-b2f0f39517aa	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_view-users}	view-users	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
ab186bb8-d3ff-41ba-ada9-65a80ba391b8	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_view-clients}	view-clients	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
3a3d7abb-9b48-4ac4-8ac9-53cecc241a43	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_view-events}	view-events	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
f1831017-5beb-4df5-952e-0f3cce5c3bb3	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_view-identity-providers}	view-identity-providers	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
e33d7875-8535-46ea-9ea4-c6b54a3334d7	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_view-authorization}	view-authorization	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
2fefbb1c-9265-4ff0-83d7-826ff9b6bf8c	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_manage-realm}	manage-realm	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
9958df72-5b7c-4cbb-a6cf-c72ba6172f75	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_manage-users}	manage-users	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
7c6b40b9-753c-4b5c-bde2-75d58984d6bc	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_manage-clients}	manage-clients	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
102b3a62-d86d-41ea-addc-9c7d53df8fd5	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_manage-events}	manage-events	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
9ae14ee6-8f27-4aae-93f8-689db2866a0f	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_manage-identity-providers}	manage-identity-providers	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
bc330cc8-e210-4bbf-a5f4-ab17768523fd	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_manage-authorization}	manage-authorization	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
eca6d41c-a5e3-4987-9e73-895d5a7c5d28	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_query-users}	query-users	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
e7851c36-4333-42c1-be3c-36b6674b6cb0	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_query-clients}	query-clients	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
da8bc897-8fe2-43dd-84cc-9299ffd3955f	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_query-realms}	query-realms	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
23b2ca2f-3292-44cc-9135-eda3dd675d86	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_query-groups}	query-groups	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_realm-admin}	realm-admin	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
44d56347-f949-43ba-8d75-4b5076238651	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_create-client}	create-client	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
fbef3d23-579b-40d4-b45c-adfe0db7a666	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_view-realm}	view-realm	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
7fc420b7-dcc5-46be-a0e9-4a4591ddaccb	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_view-users}	view-users	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
f015c524-c84e-4771-9561-8617233851a7	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_view-clients}	view-clients	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
9002b052-aacc-4e90-8299-99a85ae3b419	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_view-events}	view-events	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
eef4a17b-f018-4091-92dc-a9f2e8a9fb16	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_view-identity-providers}	view-identity-providers	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
8200d8b4-f015-4147-bac6-25fc7d181aa7	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_view-authorization}	view-authorization	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
29f51dc1-8da0-4d18-a566-8da7d32e5120	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_manage-realm}	manage-realm	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
377fd5fe-7691-4f7c-b352-bc2ac332fe79	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_manage-users}	manage-users	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
45a8b1cb-1733-4a69-bd9f-84b8804c0c0f	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_manage-clients}	manage-clients	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
cee80322-c935-4164-ad44-5f0761ab2b53	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_manage-events}	manage-events	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
9cdd04d1-48ae-4e39-8a1c-e5d747900761	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_manage-identity-providers}	manage-identity-providers	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
983de620-d6ac-4fc7-820a-e184d3779c1e	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_manage-authorization}	manage-authorization	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
100f0d47-7e3c-4512-89ae-ec5e9e838400	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_query-users}	query-users	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
d6f13609-0084-4121-bd8a-c2714064ba58	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_query-clients}	query-clients	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
a4c4e904-caaf-4732-879b-765f9824db16	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_query-realms}	query-realms	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
ba248ea5-1730-4dd9-8c9e-05e9f84421f2	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_query-groups}	query-groups	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
b0d63051-4293-452b-aa17-0e726abbe01b	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	t	${role_view-profile}	view-profile	503310e2-70f4-445d-bfe0-0c00deb5ea32	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	\N
a68d2d30-2838-4565-b05c-88dd2f5f29e2	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	t	${role_manage-account}	manage-account	503310e2-70f4-445d-bfe0-0c00deb5ea32	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	\N
a8d30b6f-d412-43ae-af54-f3ba1796b5bb	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	t	${role_manage-account-links}	manage-account-links	503310e2-70f4-445d-bfe0-0c00deb5ea32	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	\N
e3f78650-7f2d-4794-90b4-13c6864a0674	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	t	${role_view-applications}	view-applications	503310e2-70f4-445d-bfe0-0c00deb5ea32	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	\N
df42e096-50a8-4550-95c6-ab86456b5d44	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	t	${role_view-consent}	view-consent	503310e2-70f4-445d-bfe0-0c00deb5ea32	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	\N
2a2edc5f-5400-4612-a419-cc888e5b8e49	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	t	${role_manage-consent}	manage-consent	503310e2-70f4-445d-bfe0-0c00deb5ea32	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	\N
5ccbb06d-f51c-432b-80a5-588e9922de8b	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	t	${role_view-groups}	view-groups	503310e2-70f4-445d-bfe0-0c00deb5ea32	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	\N
657f3e73-cdcc-468a-9b88-4a3ad1efdb5e	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	t	${role_delete-account}	delete-account	503310e2-70f4-445d-bfe0-0c00deb5ea32	f4fa91de-2cb6-4c33-9c98-18d1fc462c33	\N
c1d23e8a-f380-456a-9756-968ac0f95ed8	14577c13-02e1-456f-a07b-4d2db438e606	t	${role_impersonation}	impersonation	f3481901-3ac1-43bb-b067-1ac965a8d282	14577c13-02e1-456f-a07b-4d2db438e606	\N
121f836f-d875-4434-98de-3ebd6b63e332	d3adf521-0ac4-460b-813c-42e7205c2f29	t	${role_impersonation}	impersonation	503310e2-70f4-445d-bfe0-0c00deb5ea32	d3adf521-0ac4-460b-813c-42e7205c2f29	\N
e4391be3-a0f4-449b-94a5-09830968ed00	00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	t	${role_read-token}	read-token	503310e2-70f4-445d-bfe0-0c00deb5ea32	00c3f3ff-74fd-4724-bcc5-0154e1ba1d69	\N
b0eea1cd-408b-48ba-b6be-9ab967d7a1db	503310e2-70f4-445d-bfe0-0c00deb5ea32	f	${role_offline-access}	offline_access	503310e2-70f4-445d-bfe0-0c00deb5ea32	\N	\N
4aac7569-4b97-433e-8442-1ae5405ba405	503310e2-70f4-445d-bfe0-0c00deb5ea32	f	${role_uma_authorization}	uma_authorization	503310e2-70f4-445d-bfe0-0c00deb5ea32	\N	\N
e3824ebf-d5c1-445a-9cb7-9af28c2e7b64	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	t	\N	uma_protection	503310e2-70f4-445d-bfe0-0c00deb5ea32	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
003nr	26.0.7	1738200316
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
cf74eb01-3e9e-45c9-9386-2c85b67d1326	cc8ea444-0ef6-47dc-94c8-9baf324015d3	0	1738203282	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/realms/hackaton/account/","notes":{"clientId":"cc8ea444-0ef6-47dc-94c8-9baf324015d3","iss":"http://localhost:8082/realms/hackaton","startedAt":"1738203282","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"f0a06812-7a09-457c-84d1-81a443868613","response_mode":"query","scope":"openid","userSessionStartedAt":"1738203282","redirect_uri":"http://localhost:8082/realms/hackaton/account/","state":"7fb38ff6-4010-4775-875e-25418f4bf8ce","code_challenge":"IMVAF7-ayniMLBJ_2d2v0hjr1eP2tZNhO_kSZJihaOA"}}	local	local	0
d8c94c48-50ae-4034-bd0b-43aeb74f3ef7	8cc74036-ce0b-40fb-bad4-213c98d2cef6	0	1738204423	{"authMethod":"openid-connect","redirectUri":"http://localhost:8082/admin/master/console/#/hackaton/users/b2214428-35ec-4168-9555-5aed1f0c88d6/settings","notes":{"clientId":"8cc74036-ce0b-40fb-bad4-213c98d2cef6","iss":"http://localhost:8082/realms/master","startedAt":"1738200539","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"0180ced3-fbd0-4b0e-a886-d485ebe9c392","response_mode":"query","scope":"openid","userSessionStartedAt":"1738200539","redirect_uri":"http://localhost:8082/admin/master/console/#/hackaton/users/b2214428-35ec-4168-9555-5aed1f0c88d6/settings","state":"b1a9c2db-6fed-45cb-b51b-b06c07f332c2","code_challenge":"wUwflz54Fbfrfkkdp0ZcXM61fAgtgOeO8b1n59c0AcQ","SSO_AUTH":"true"}}	local	local	21
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
cf74eb01-3e9e-45c9-9386-2c85b67d1326	ff9ca1bc-849a-48cb-8236-77986d6434ba	503310e2-70f4-445d-bfe0-0c00deb5ea32	1738203282	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiU2FmYXJpLzE3LjYiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1738203282","authenticators-completed":"{\\"5ac2bd72-14e0-46d7-bc40-3c209d43a3ef\\":1738203282}"},"state":"LOGGED_IN"}	1738203290	\N	2
d8c94c48-50ae-4034-bd0b-43aeb74f3ef7	45b1f57d-e7f7-4a1d-8243-f16b764ce165	f3481901-3ac1-43bb-b067-1ac965a8d282	1738200539	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJNYWMgT1MgWCIsIm9zVmVyc2lvbiI6IjEwLjE1LjciLCJicm93c2VyIjoiU2FmYXJpLzE3LjYiLCJkZXZpY2UiOiJNYWMiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1738200539","authenticators-completed":"{\\"01524b34-f751-4055-9e72-e0fbf9938eec\\":1738200539,\\"918bb55d-c6fb-4a09-8f6d-7f139e7e617a\\":1738200542}"},"state":"LOGGED_IN"}	1738204423	\N	21
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
e47bac88-e9a6-4e8a-9831-bf499f39a2a9	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
5ddcbf29-cc76-42b4-9100-a3b00cb572e0	defaultResourceType	urn:hackaton-app:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
71df9d22-5cf3-4728-8aad-90fcdd387dd7	audience resolve	openid-connect	oidc-audience-resolve-mapper	cc320807-24a8-4be4-949b-4b75fcdb982c	\N
91c81106-07dd-4c27-82ba-5e194927aa17	locale	openid-connect	oidc-usermodel-attribute-mapper	8cc74036-ce0b-40fb-bad4-213c98d2cef6	\N
668f4413-bdd7-4b7c-86c2-863b6b4befd6	role list	saml	saml-role-list-mapper	\N	1c29c3e9-540e-43c8-a428-fd7fad46c123
6f7c1c4b-bf7f-43d2-ab35-0efb3e5f507e	organization	saml	saml-organization-membership-mapper	\N	2e44bf17-d2ed-4361-aa01-1ec0d6dbf995
182c3042-180d-41a4-ba7f-2f12f26b74b5	full name	openid-connect	oidc-full-name-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
2c680c4c-1340-46ef-b502-b2b96429c016	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
4c8f07e3-0366-4b71-b94c-934589a6bf8b	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
619227af-bb20-4d03-b042-bc301de2361b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
dd2c424f-d7f3-4958-92e7-a04c0522d46c	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
dcde0d2c-b705-41eb-9669-68047e81aeb3	username	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
a73bfc09-0475-4e02-9e00-629082714c79	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
aac3f52d-c839-4b39-9e6d-bc7034f3df94	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
70d1f78a-370e-4bfb-8e4b-caced3ac63c2	website	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
5c321ddf-5053-4864-9a1d-b506a045aa94	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
f2fe475b-75c9-4e83-a426-4a38849568e6	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
b7b09597-a362-4b5a-864b-83bbfb462950	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
bd3561a1-fecb-4ca2-9ef7-459e5cd16a1c	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
c9b919b5-637c-44a4-b135-0873da985524	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	68afe76a-a9ac-4f7e-b5ba-6267a2b3a612
149d1675-6863-4390-9012-0cf105ed849a	email	openid-connect	oidc-usermodel-attribute-mapper	\N	4b02e0ab-5c9b-4363-ba7e-8821c22ce76b
5366a95f-8c0c-40b1-8c75-302d7fde9011	email verified	openid-connect	oidc-usermodel-property-mapper	\N	4b02e0ab-5c9b-4363-ba7e-8821c22ce76b
42ab15e1-c44c-4c77-a38a-be606794485a	address	openid-connect	oidc-address-mapper	\N	a949e6d8-6404-47a1-8d5a-d6b5d67b7a0e
0e249b9d-7487-44a6-8c58-9a38d3babe2b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	2baec8d4-9279-4cc3-812d-26a55ce86a19
cd05f481-e7ae-4a0b-9436-b0bf5d882d8c	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	2baec8d4-9279-4cc3-812d-26a55ce86a19
4328e38e-f935-44fc-8bc1-2d952203eae8	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	731c0c0a-78b4-4a73-93ee-60ac219ddb7e
88340cce-4c70-4544-849d-5e104ddf3eff	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	731c0c0a-78b4-4a73-93ee-60ac219ddb7e
a5b005de-4829-4c97-a379-621bfcd1805c	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	731c0c0a-78b4-4a73-93ee-60ac219ddb7e
83c65cb2-b01a-4473-bcf5-5419f223912a	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	d1378567-9a9b-4b5a-bca2-d5913c6abe4b
ab3b8352-73f9-49b5-91f6-bd6164a31a8c	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	c017baf6-10d4-4df8-97a2-fd2cb7ba59c0
0ce3bb5d-88a0-494f-8cec-943274d157e5	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	c017baf6-10d4-4df8-97a2-fd2cb7ba59c0
720be27c-e664-4321-bb8b-f6c42f85fac0	acr loa level	openid-connect	oidc-acr-mapper	\N	4e9a4d44-1a02-4b4e-baaf-0ab259f92ec5
2c314df5-5098-49e3-8783-eeb3450e6cb6	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	8a6d7158-e3d7-4b35-96e3-0c18e9e0a663
e8520c56-b006-4929-86e1-d03dd1fb2909	sub	openid-connect	oidc-sub-mapper	\N	8a6d7158-e3d7-4b35-96e3-0c18e9e0a663
a90cc775-2998-4410-b808-9f3dbe92f377	organization	openid-connect	oidc-organization-membership-mapper	\N	9d684b80-7dfa-462c-bd69-01f018106004
d5f7f09e-8a1c-4e1e-b9d8-eca46caae357	audience resolve	openid-connect	oidc-audience-resolve-mapper	cc8ea444-0ef6-47dc-94c8-9baf324015d3	\N
d8785441-fa52-48a5-9cad-b73f871e0e87	role list	saml	saml-role-list-mapper	\N	47065527-0797-4d89-a387-3ced372d8c61
1961def8-9123-46df-bd78-e5cff798d402	organization	saml	saml-organization-membership-mapper	\N	a94aff13-c1a7-4c99-82ad-809246f11c85
63c3dd91-9c26-421d-823b-c28afa55da16	full name	openid-connect	oidc-full-name-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
92330b91-d45d-4c74-b3b3-392090ab10cb	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
996fc4a5-b06a-423f-91ec-1f4822bb9270	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
32fd2dcd-7da1-404e-ab42-8abafa4cfb5c	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
a5b9bfa8-a818-42a7-9291-8d06ee2b5fc4	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
5dc026c2-903c-488a-8771-eedea1411050	username	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
f4b4eae0-ae48-4d18-b487-0bcdafba531f	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
0f1f67ba-16b3-487e-8d2b-0f1c3e8aa27a	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
c79c3c25-9f66-4ad8-b0f6-d96484e877f4	website	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
094a205c-f806-4c14-add4-bc4cc3807c7d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
2ec4cff1-ba9f-4787-9924-7b4e36c914c7	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
6ccad460-c417-4d84-9449-d1eda66c7d95	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
11843402-7e30-40cd-b21a-c5a82a602b35	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
9c602bdb-86ad-4c18-bf50-30200e6ff2dc	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	9f46cfe8-6f2e-4270-bfbb-3f68e2a71e43
c8cc0c8a-0ad8-499c-bc37-324601f93b1e	email	openid-connect	oidc-usermodel-attribute-mapper	\N	ee8e6063-f7ad-4396-a283-3a7ec8b40438
4ed4c795-8f84-41ed-a55e-1db1b4055847	email verified	openid-connect	oidc-usermodel-property-mapper	\N	ee8e6063-f7ad-4396-a283-3a7ec8b40438
1064536d-1132-4ee2-823d-29c955d18802	address	openid-connect	oidc-address-mapper	\N	7a0ccfaf-19bb-466f-adfc-a45e3cc82ad5
ec258bfe-cc72-487c-9b87-95a320b1df4a	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	8f3984b6-bc11-469b-a9cc-e5226b78a886
8e04ad85-7259-4cd3-9971-5c6a06fc436f	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	8f3984b6-bc11-469b-a9cc-e5226b78a886
d7d723ee-c0d3-4aaf-b01c-e2fd84ed343b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb
fe7e69c3-e82c-4252-bf89-835391d7d842	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb
6406534a-81e4-4b74-aba4-46b8c3b91047	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	7ddc53ec-94c9-4fab-9d21-db8b0dd0ddfb
229f363e-41e5-4ece-b400-5cd0a78198ba	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	a1e10876-e6de-48ce-be9e-4c0147e6983d
1e8df5e7-6f06-44d0-a93e-030d83671274	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	3519f343-cbda-441c-87a0-5042d7963e55
7e0da82e-a7e2-4ac6-a8ba-5af9d1c24133	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	3519f343-cbda-441c-87a0-5042d7963e55
ce10ba34-8b6a-436e-bf4b-106fe2bbb5f8	acr loa level	openid-connect	oidc-acr-mapper	\N	6cbf8bad-0262-4b4a-91b3-507944b1f138
996fb432-86a3-4474-a614-715cbb05bcbc	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	47396527-458e-4dfa-a421-41e1e32561eb
50ba2287-5d55-4fec-a204-b1b4b709dd9a	sub	openid-connect	oidc-sub-mapper	\N	47396527-458e-4dfa-a421-41e1e32561eb
42b6f5fc-6f67-4f2e-b16b-514da044d9ad	organization	openid-connect	oidc-organization-membership-mapper	\N	01a7bfb5-2588-426c-9176-e59c5c2351a9
20df9a68-d2bc-4037-bf32-36511c750ed2	locale	openid-connect	oidc-usermodel-attribute-mapper	56129fd8-266b-47e1-8227-c4dcfbc9f44e	\N
30c113e7-89df-4522-b5b3-d47024eb0064	email	openid-connect	oidc-usermodel-attribute-mapper	624c4e19-9555-4276-b671-7371b1cbeb8c	\N
47fc57f9-f0a3-4df9-be22-ca2f6f4e0fd6	family name	openid-connect	oidc-usermodel-attribute-mapper	624c4e19-9555-4276-b671-7371b1cbeb8c	\N
9d9d926a-4ccf-41f1-b361-93c8dd9d9dfc	full name	openid-connect	oidc-full-name-mapper	624c4e19-9555-4276-b671-7371b1cbeb8c	\N
e7e8497e-b863-43bd-a247-cd087bd484ea	groups	openid-connect	oidc-usermodel-realm-role-mapper	624c4e19-9555-4276-b671-7371b1cbeb8c	\N
2e7b2768-68e1-4ffa-b7c2-f3de8637d490	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	624c4e19-9555-4276-b671-7371b1cbeb8c	\N
d55136b5-8c20-4086-af2b-ca2cba86a124	username	openid-connect	oidc-usermodel-attribute-mapper	624c4e19-9555-4276-b671-7371b1cbeb8c	\N
86b64975-fc0a-43c2-b793-2e6d6645819a	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
0255237c-7a1e-4b7c-b5c6-713536b829c3	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
2f129c36-154b-4526-9d1f-f39d8e71b09c	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
446fb4c3-f766-4abd-8e15-3be87a6d2535	client roles	openid-connect	oidc-usermodel-client-role-mapper	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
bbc21ab2-1e57-490e-89eb-ccfa612fc603	email	openid-connect	oidc-usermodel-attribute-mapper	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
3fe2ea25-438d-4b36-9919-bd069dc080df	email verified	openid-connect	oidc-usermodel-property-mapper	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
8648f9e7-63ba-4693-88b9-8bedd1e6a687	family name	openid-connect	oidc-usermodel-attribute-mapper	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
5253c017-8fb2-4eef-9bda-cfdc3ef88172	full name	openid-connect	oidc-full-name-mapper	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
582bfbb4-fad6-464b-8975-346d11f2cd7b	nickname	openid-connect	oidc-usermodel-attribute-mapper	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
6f8272b6-6493-4313-8347-bb2828e07c9e	username	openid-connect	oidc-usermodel-attribute-mapper	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
91c81106-07dd-4c27-82ba-5e194927aa17	true	introspection.token.claim
91c81106-07dd-4c27-82ba-5e194927aa17	true	userinfo.token.claim
91c81106-07dd-4c27-82ba-5e194927aa17	locale	user.attribute
91c81106-07dd-4c27-82ba-5e194927aa17	true	id.token.claim
91c81106-07dd-4c27-82ba-5e194927aa17	true	access.token.claim
91c81106-07dd-4c27-82ba-5e194927aa17	locale	claim.name
91c81106-07dd-4c27-82ba-5e194927aa17	String	jsonType.label
668f4413-bdd7-4b7c-86c2-863b6b4befd6	false	single
668f4413-bdd7-4b7c-86c2-863b6b4befd6	Basic	attribute.nameformat
668f4413-bdd7-4b7c-86c2-863b6b4befd6	Role	attribute.name
182c3042-180d-41a4-ba7f-2f12f26b74b5	true	introspection.token.claim
182c3042-180d-41a4-ba7f-2f12f26b74b5	true	userinfo.token.claim
182c3042-180d-41a4-ba7f-2f12f26b74b5	true	id.token.claim
182c3042-180d-41a4-ba7f-2f12f26b74b5	true	access.token.claim
2c680c4c-1340-46ef-b502-b2b96429c016	true	introspection.token.claim
2c680c4c-1340-46ef-b502-b2b96429c016	true	userinfo.token.claim
2c680c4c-1340-46ef-b502-b2b96429c016	lastName	user.attribute
2c680c4c-1340-46ef-b502-b2b96429c016	true	id.token.claim
2c680c4c-1340-46ef-b502-b2b96429c016	true	access.token.claim
2c680c4c-1340-46ef-b502-b2b96429c016	family_name	claim.name
2c680c4c-1340-46ef-b502-b2b96429c016	String	jsonType.label
4c8f07e3-0366-4b71-b94c-934589a6bf8b	true	introspection.token.claim
4c8f07e3-0366-4b71-b94c-934589a6bf8b	true	userinfo.token.claim
4c8f07e3-0366-4b71-b94c-934589a6bf8b	firstName	user.attribute
4c8f07e3-0366-4b71-b94c-934589a6bf8b	true	id.token.claim
4c8f07e3-0366-4b71-b94c-934589a6bf8b	true	access.token.claim
4c8f07e3-0366-4b71-b94c-934589a6bf8b	given_name	claim.name
4c8f07e3-0366-4b71-b94c-934589a6bf8b	String	jsonType.label
5c321ddf-5053-4864-9a1d-b506a045aa94	true	introspection.token.claim
5c321ddf-5053-4864-9a1d-b506a045aa94	true	userinfo.token.claim
5c321ddf-5053-4864-9a1d-b506a045aa94	gender	user.attribute
5c321ddf-5053-4864-9a1d-b506a045aa94	true	id.token.claim
5c321ddf-5053-4864-9a1d-b506a045aa94	true	access.token.claim
5c321ddf-5053-4864-9a1d-b506a045aa94	gender	claim.name
5c321ddf-5053-4864-9a1d-b506a045aa94	String	jsonType.label
619227af-bb20-4d03-b042-bc301de2361b	true	introspection.token.claim
619227af-bb20-4d03-b042-bc301de2361b	true	userinfo.token.claim
619227af-bb20-4d03-b042-bc301de2361b	middleName	user.attribute
619227af-bb20-4d03-b042-bc301de2361b	true	id.token.claim
619227af-bb20-4d03-b042-bc301de2361b	true	access.token.claim
619227af-bb20-4d03-b042-bc301de2361b	middle_name	claim.name
619227af-bb20-4d03-b042-bc301de2361b	String	jsonType.label
70d1f78a-370e-4bfb-8e4b-caced3ac63c2	true	introspection.token.claim
70d1f78a-370e-4bfb-8e4b-caced3ac63c2	true	userinfo.token.claim
70d1f78a-370e-4bfb-8e4b-caced3ac63c2	website	user.attribute
70d1f78a-370e-4bfb-8e4b-caced3ac63c2	true	id.token.claim
70d1f78a-370e-4bfb-8e4b-caced3ac63c2	true	access.token.claim
70d1f78a-370e-4bfb-8e4b-caced3ac63c2	website	claim.name
70d1f78a-370e-4bfb-8e4b-caced3ac63c2	String	jsonType.label
a73bfc09-0475-4e02-9e00-629082714c79	true	introspection.token.claim
a73bfc09-0475-4e02-9e00-629082714c79	true	userinfo.token.claim
a73bfc09-0475-4e02-9e00-629082714c79	profile	user.attribute
a73bfc09-0475-4e02-9e00-629082714c79	true	id.token.claim
a73bfc09-0475-4e02-9e00-629082714c79	true	access.token.claim
a73bfc09-0475-4e02-9e00-629082714c79	profile	claim.name
a73bfc09-0475-4e02-9e00-629082714c79	String	jsonType.label
aac3f52d-c839-4b39-9e6d-bc7034f3df94	true	introspection.token.claim
aac3f52d-c839-4b39-9e6d-bc7034f3df94	true	userinfo.token.claim
aac3f52d-c839-4b39-9e6d-bc7034f3df94	picture	user.attribute
aac3f52d-c839-4b39-9e6d-bc7034f3df94	true	id.token.claim
aac3f52d-c839-4b39-9e6d-bc7034f3df94	true	access.token.claim
aac3f52d-c839-4b39-9e6d-bc7034f3df94	picture	claim.name
aac3f52d-c839-4b39-9e6d-bc7034f3df94	String	jsonType.label
b7b09597-a362-4b5a-864b-83bbfb462950	true	introspection.token.claim
b7b09597-a362-4b5a-864b-83bbfb462950	true	userinfo.token.claim
b7b09597-a362-4b5a-864b-83bbfb462950	zoneinfo	user.attribute
b7b09597-a362-4b5a-864b-83bbfb462950	true	id.token.claim
b7b09597-a362-4b5a-864b-83bbfb462950	true	access.token.claim
b7b09597-a362-4b5a-864b-83bbfb462950	zoneinfo	claim.name
b7b09597-a362-4b5a-864b-83bbfb462950	String	jsonType.label
bd3561a1-fecb-4ca2-9ef7-459e5cd16a1c	true	introspection.token.claim
bd3561a1-fecb-4ca2-9ef7-459e5cd16a1c	true	userinfo.token.claim
bd3561a1-fecb-4ca2-9ef7-459e5cd16a1c	locale	user.attribute
bd3561a1-fecb-4ca2-9ef7-459e5cd16a1c	true	id.token.claim
bd3561a1-fecb-4ca2-9ef7-459e5cd16a1c	true	access.token.claim
bd3561a1-fecb-4ca2-9ef7-459e5cd16a1c	locale	claim.name
bd3561a1-fecb-4ca2-9ef7-459e5cd16a1c	String	jsonType.label
c9b919b5-637c-44a4-b135-0873da985524	true	introspection.token.claim
c9b919b5-637c-44a4-b135-0873da985524	true	userinfo.token.claim
c9b919b5-637c-44a4-b135-0873da985524	updatedAt	user.attribute
c9b919b5-637c-44a4-b135-0873da985524	true	id.token.claim
c9b919b5-637c-44a4-b135-0873da985524	true	access.token.claim
c9b919b5-637c-44a4-b135-0873da985524	updated_at	claim.name
c9b919b5-637c-44a4-b135-0873da985524	long	jsonType.label
dcde0d2c-b705-41eb-9669-68047e81aeb3	true	introspection.token.claim
dcde0d2c-b705-41eb-9669-68047e81aeb3	true	userinfo.token.claim
dcde0d2c-b705-41eb-9669-68047e81aeb3	username	user.attribute
dcde0d2c-b705-41eb-9669-68047e81aeb3	true	id.token.claim
dcde0d2c-b705-41eb-9669-68047e81aeb3	true	access.token.claim
dcde0d2c-b705-41eb-9669-68047e81aeb3	preferred_username	claim.name
dcde0d2c-b705-41eb-9669-68047e81aeb3	String	jsonType.label
dd2c424f-d7f3-4958-92e7-a04c0522d46c	true	introspection.token.claim
dd2c424f-d7f3-4958-92e7-a04c0522d46c	true	userinfo.token.claim
dd2c424f-d7f3-4958-92e7-a04c0522d46c	nickname	user.attribute
dd2c424f-d7f3-4958-92e7-a04c0522d46c	true	id.token.claim
dd2c424f-d7f3-4958-92e7-a04c0522d46c	true	access.token.claim
dd2c424f-d7f3-4958-92e7-a04c0522d46c	nickname	claim.name
dd2c424f-d7f3-4958-92e7-a04c0522d46c	String	jsonType.label
f2fe475b-75c9-4e83-a426-4a38849568e6	true	introspection.token.claim
f2fe475b-75c9-4e83-a426-4a38849568e6	true	userinfo.token.claim
f2fe475b-75c9-4e83-a426-4a38849568e6	birthdate	user.attribute
f2fe475b-75c9-4e83-a426-4a38849568e6	true	id.token.claim
f2fe475b-75c9-4e83-a426-4a38849568e6	true	access.token.claim
f2fe475b-75c9-4e83-a426-4a38849568e6	birthdate	claim.name
f2fe475b-75c9-4e83-a426-4a38849568e6	String	jsonType.label
149d1675-6863-4390-9012-0cf105ed849a	true	introspection.token.claim
149d1675-6863-4390-9012-0cf105ed849a	true	userinfo.token.claim
149d1675-6863-4390-9012-0cf105ed849a	email	user.attribute
149d1675-6863-4390-9012-0cf105ed849a	true	id.token.claim
149d1675-6863-4390-9012-0cf105ed849a	true	access.token.claim
149d1675-6863-4390-9012-0cf105ed849a	email	claim.name
149d1675-6863-4390-9012-0cf105ed849a	String	jsonType.label
5366a95f-8c0c-40b1-8c75-302d7fde9011	true	introspection.token.claim
5366a95f-8c0c-40b1-8c75-302d7fde9011	true	userinfo.token.claim
5366a95f-8c0c-40b1-8c75-302d7fde9011	emailVerified	user.attribute
5366a95f-8c0c-40b1-8c75-302d7fde9011	true	id.token.claim
5366a95f-8c0c-40b1-8c75-302d7fde9011	true	access.token.claim
5366a95f-8c0c-40b1-8c75-302d7fde9011	email_verified	claim.name
5366a95f-8c0c-40b1-8c75-302d7fde9011	boolean	jsonType.label
42ab15e1-c44c-4c77-a38a-be606794485a	formatted	user.attribute.formatted
42ab15e1-c44c-4c77-a38a-be606794485a	country	user.attribute.country
42ab15e1-c44c-4c77-a38a-be606794485a	true	introspection.token.claim
42ab15e1-c44c-4c77-a38a-be606794485a	postal_code	user.attribute.postal_code
42ab15e1-c44c-4c77-a38a-be606794485a	true	userinfo.token.claim
42ab15e1-c44c-4c77-a38a-be606794485a	street	user.attribute.street
42ab15e1-c44c-4c77-a38a-be606794485a	true	id.token.claim
42ab15e1-c44c-4c77-a38a-be606794485a	region	user.attribute.region
42ab15e1-c44c-4c77-a38a-be606794485a	true	access.token.claim
42ab15e1-c44c-4c77-a38a-be606794485a	locality	user.attribute.locality
0e249b9d-7487-44a6-8c58-9a38d3babe2b	true	introspection.token.claim
0e249b9d-7487-44a6-8c58-9a38d3babe2b	true	userinfo.token.claim
0e249b9d-7487-44a6-8c58-9a38d3babe2b	phoneNumber	user.attribute
0e249b9d-7487-44a6-8c58-9a38d3babe2b	true	id.token.claim
0e249b9d-7487-44a6-8c58-9a38d3babe2b	true	access.token.claim
0e249b9d-7487-44a6-8c58-9a38d3babe2b	phone_number	claim.name
0e249b9d-7487-44a6-8c58-9a38d3babe2b	String	jsonType.label
cd05f481-e7ae-4a0b-9436-b0bf5d882d8c	true	introspection.token.claim
cd05f481-e7ae-4a0b-9436-b0bf5d882d8c	true	userinfo.token.claim
cd05f481-e7ae-4a0b-9436-b0bf5d882d8c	phoneNumberVerified	user.attribute
cd05f481-e7ae-4a0b-9436-b0bf5d882d8c	true	id.token.claim
cd05f481-e7ae-4a0b-9436-b0bf5d882d8c	true	access.token.claim
cd05f481-e7ae-4a0b-9436-b0bf5d882d8c	phone_number_verified	claim.name
cd05f481-e7ae-4a0b-9436-b0bf5d882d8c	boolean	jsonType.label
4328e38e-f935-44fc-8bc1-2d952203eae8	true	introspection.token.claim
4328e38e-f935-44fc-8bc1-2d952203eae8	true	multivalued
4328e38e-f935-44fc-8bc1-2d952203eae8	foo	user.attribute
4328e38e-f935-44fc-8bc1-2d952203eae8	true	access.token.claim
4328e38e-f935-44fc-8bc1-2d952203eae8	realm_access.roles	claim.name
4328e38e-f935-44fc-8bc1-2d952203eae8	String	jsonType.label
88340cce-4c70-4544-849d-5e104ddf3eff	true	introspection.token.claim
88340cce-4c70-4544-849d-5e104ddf3eff	true	multivalued
88340cce-4c70-4544-849d-5e104ddf3eff	foo	user.attribute
88340cce-4c70-4544-849d-5e104ddf3eff	true	access.token.claim
88340cce-4c70-4544-849d-5e104ddf3eff	resource_access.${client_id}.roles	claim.name
88340cce-4c70-4544-849d-5e104ddf3eff	String	jsonType.label
a5b005de-4829-4c97-a379-621bfcd1805c	true	introspection.token.claim
a5b005de-4829-4c97-a379-621bfcd1805c	true	access.token.claim
83c65cb2-b01a-4473-bcf5-5419f223912a	true	introspection.token.claim
83c65cb2-b01a-4473-bcf5-5419f223912a	true	access.token.claim
0ce3bb5d-88a0-494f-8cec-943274d157e5	true	introspection.token.claim
0ce3bb5d-88a0-494f-8cec-943274d157e5	true	multivalued
0ce3bb5d-88a0-494f-8cec-943274d157e5	foo	user.attribute
0ce3bb5d-88a0-494f-8cec-943274d157e5	true	id.token.claim
0ce3bb5d-88a0-494f-8cec-943274d157e5	true	access.token.claim
0ce3bb5d-88a0-494f-8cec-943274d157e5	groups	claim.name
0ce3bb5d-88a0-494f-8cec-943274d157e5	String	jsonType.label
ab3b8352-73f9-49b5-91f6-bd6164a31a8c	true	introspection.token.claim
ab3b8352-73f9-49b5-91f6-bd6164a31a8c	true	userinfo.token.claim
ab3b8352-73f9-49b5-91f6-bd6164a31a8c	username	user.attribute
ab3b8352-73f9-49b5-91f6-bd6164a31a8c	true	id.token.claim
ab3b8352-73f9-49b5-91f6-bd6164a31a8c	true	access.token.claim
ab3b8352-73f9-49b5-91f6-bd6164a31a8c	upn	claim.name
ab3b8352-73f9-49b5-91f6-bd6164a31a8c	String	jsonType.label
720be27c-e664-4321-bb8b-f6c42f85fac0	true	introspection.token.claim
720be27c-e664-4321-bb8b-f6c42f85fac0	true	id.token.claim
720be27c-e664-4321-bb8b-f6c42f85fac0	true	access.token.claim
2c314df5-5098-49e3-8783-eeb3450e6cb6	AUTH_TIME	user.session.note
2c314df5-5098-49e3-8783-eeb3450e6cb6	true	introspection.token.claim
2c314df5-5098-49e3-8783-eeb3450e6cb6	true	id.token.claim
2c314df5-5098-49e3-8783-eeb3450e6cb6	true	access.token.claim
2c314df5-5098-49e3-8783-eeb3450e6cb6	auth_time	claim.name
2c314df5-5098-49e3-8783-eeb3450e6cb6	long	jsonType.label
e8520c56-b006-4929-86e1-d03dd1fb2909	true	introspection.token.claim
e8520c56-b006-4929-86e1-d03dd1fb2909	true	access.token.claim
a90cc775-2998-4410-b808-9f3dbe92f377	true	introspection.token.claim
a90cc775-2998-4410-b808-9f3dbe92f377	true	multivalued
a90cc775-2998-4410-b808-9f3dbe92f377	true	id.token.claim
a90cc775-2998-4410-b808-9f3dbe92f377	true	access.token.claim
a90cc775-2998-4410-b808-9f3dbe92f377	organization	claim.name
a90cc775-2998-4410-b808-9f3dbe92f377	String	jsonType.label
d8785441-fa52-48a5-9cad-b73f871e0e87	false	single
d8785441-fa52-48a5-9cad-b73f871e0e87	Basic	attribute.nameformat
d8785441-fa52-48a5-9cad-b73f871e0e87	Role	attribute.name
094a205c-f806-4c14-add4-bc4cc3807c7d	true	introspection.token.claim
094a205c-f806-4c14-add4-bc4cc3807c7d	true	userinfo.token.claim
094a205c-f806-4c14-add4-bc4cc3807c7d	gender	user.attribute
094a205c-f806-4c14-add4-bc4cc3807c7d	true	id.token.claim
094a205c-f806-4c14-add4-bc4cc3807c7d	true	access.token.claim
094a205c-f806-4c14-add4-bc4cc3807c7d	gender	claim.name
094a205c-f806-4c14-add4-bc4cc3807c7d	String	jsonType.label
0f1f67ba-16b3-487e-8d2b-0f1c3e8aa27a	true	introspection.token.claim
0f1f67ba-16b3-487e-8d2b-0f1c3e8aa27a	true	userinfo.token.claim
0f1f67ba-16b3-487e-8d2b-0f1c3e8aa27a	picture	user.attribute
0f1f67ba-16b3-487e-8d2b-0f1c3e8aa27a	true	id.token.claim
0f1f67ba-16b3-487e-8d2b-0f1c3e8aa27a	true	access.token.claim
0f1f67ba-16b3-487e-8d2b-0f1c3e8aa27a	picture	claim.name
0f1f67ba-16b3-487e-8d2b-0f1c3e8aa27a	String	jsonType.label
11843402-7e30-40cd-b21a-c5a82a602b35	true	introspection.token.claim
11843402-7e30-40cd-b21a-c5a82a602b35	true	userinfo.token.claim
11843402-7e30-40cd-b21a-c5a82a602b35	locale	user.attribute
11843402-7e30-40cd-b21a-c5a82a602b35	true	id.token.claim
11843402-7e30-40cd-b21a-c5a82a602b35	true	access.token.claim
11843402-7e30-40cd-b21a-c5a82a602b35	locale	claim.name
11843402-7e30-40cd-b21a-c5a82a602b35	String	jsonType.label
2ec4cff1-ba9f-4787-9924-7b4e36c914c7	true	introspection.token.claim
2ec4cff1-ba9f-4787-9924-7b4e36c914c7	true	userinfo.token.claim
2ec4cff1-ba9f-4787-9924-7b4e36c914c7	birthdate	user.attribute
2ec4cff1-ba9f-4787-9924-7b4e36c914c7	true	id.token.claim
2ec4cff1-ba9f-4787-9924-7b4e36c914c7	true	access.token.claim
2ec4cff1-ba9f-4787-9924-7b4e36c914c7	birthdate	claim.name
2ec4cff1-ba9f-4787-9924-7b4e36c914c7	String	jsonType.label
32fd2dcd-7da1-404e-ab42-8abafa4cfb5c	true	introspection.token.claim
32fd2dcd-7da1-404e-ab42-8abafa4cfb5c	true	userinfo.token.claim
32fd2dcd-7da1-404e-ab42-8abafa4cfb5c	middleName	user.attribute
32fd2dcd-7da1-404e-ab42-8abafa4cfb5c	true	id.token.claim
32fd2dcd-7da1-404e-ab42-8abafa4cfb5c	true	access.token.claim
32fd2dcd-7da1-404e-ab42-8abafa4cfb5c	middle_name	claim.name
32fd2dcd-7da1-404e-ab42-8abafa4cfb5c	String	jsonType.label
5dc026c2-903c-488a-8771-eedea1411050	true	introspection.token.claim
5dc026c2-903c-488a-8771-eedea1411050	true	userinfo.token.claim
5dc026c2-903c-488a-8771-eedea1411050	username	user.attribute
5dc026c2-903c-488a-8771-eedea1411050	true	id.token.claim
5dc026c2-903c-488a-8771-eedea1411050	true	access.token.claim
5dc026c2-903c-488a-8771-eedea1411050	preferred_username	claim.name
5dc026c2-903c-488a-8771-eedea1411050	String	jsonType.label
63c3dd91-9c26-421d-823b-c28afa55da16	true	introspection.token.claim
63c3dd91-9c26-421d-823b-c28afa55da16	true	userinfo.token.claim
63c3dd91-9c26-421d-823b-c28afa55da16	true	id.token.claim
63c3dd91-9c26-421d-823b-c28afa55da16	true	access.token.claim
6ccad460-c417-4d84-9449-d1eda66c7d95	true	introspection.token.claim
6ccad460-c417-4d84-9449-d1eda66c7d95	true	userinfo.token.claim
6ccad460-c417-4d84-9449-d1eda66c7d95	zoneinfo	user.attribute
6ccad460-c417-4d84-9449-d1eda66c7d95	true	id.token.claim
6ccad460-c417-4d84-9449-d1eda66c7d95	true	access.token.claim
6ccad460-c417-4d84-9449-d1eda66c7d95	zoneinfo	claim.name
6ccad460-c417-4d84-9449-d1eda66c7d95	String	jsonType.label
92330b91-d45d-4c74-b3b3-392090ab10cb	true	introspection.token.claim
92330b91-d45d-4c74-b3b3-392090ab10cb	true	userinfo.token.claim
92330b91-d45d-4c74-b3b3-392090ab10cb	lastName	user.attribute
92330b91-d45d-4c74-b3b3-392090ab10cb	true	id.token.claim
92330b91-d45d-4c74-b3b3-392090ab10cb	true	access.token.claim
92330b91-d45d-4c74-b3b3-392090ab10cb	family_name	claim.name
92330b91-d45d-4c74-b3b3-392090ab10cb	String	jsonType.label
996fc4a5-b06a-423f-91ec-1f4822bb9270	true	introspection.token.claim
996fc4a5-b06a-423f-91ec-1f4822bb9270	true	userinfo.token.claim
996fc4a5-b06a-423f-91ec-1f4822bb9270	firstName	user.attribute
996fc4a5-b06a-423f-91ec-1f4822bb9270	true	id.token.claim
996fc4a5-b06a-423f-91ec-1f4822bb9270	true	access.token.claim
996fc4a5-b06a-423f-91ec-1f4822bb9270	given_name	claim.name
996fc4a5-b06a-423f-91ec-1f4822bb9270	String	jsonType.label
9c602bdb-86ad-4c18-bf50-30200e6ff2dc	true	introspection.token.claim
9c602bdb-86ad-4c18-bf50-30200e6ff2dc	true	userinfo.token.claim
9c602bdb-86ad-4c18-bf50-30200e6ff2dc	updatedAt	user.attribute
9c602bdb-86ad-4c18-bf50-30200e6ff2dc	true	id.token.claim
9c602bdb-86ad-4c18-bf50-30200e6ff2dc	true	access.token.claim
9c602bdb-86ad-4c18-bf50-30200e6ff2dc	updated_at	claim.name
9c602bdb-86ad-4c18-bf50-30200e6ff2dc	long	jsonType.label
a5b9bfa8-a818-42a7-9291-8d06ee2b5fc4	true	introspection.token.claim
a5b9bfa8-a818-42a7-9291-8d06ee2b5fc4	true	userinfo.token.claim
a5b9bfa8-a818-42a7-9291-8d06ee2b5fc4	nickname	user.attribute
a5b9bfa8-a818-42a7-9291-8d06ee2b5fc4	true	id.token.claim
a5b9bfa8-a818-42a7-9291-8d06ee2b5fc4	true	access.token.claim
a5b9bfa8-a818-42a7-9291-8d06ee2b5fc4	nickname	claim.name
a5b9bfa8-a818-42a7-9291-8d06ee2b5fc4	String	jsonType.label
c79c3c25-9f66-4ad8-b0f6-d96484e877f4	true	introspection.token.claim
c79c3c25-9f66-4ad8-b0f6-d96484e877f4	true	userinfo.token.claim
c79c3c25-9f66-4ad8-b0f6-d96484e877f4	website	user.attribute
c79c3c25-9f66-4ad8-b0f6-d96484e877f4	true	id.token.claim
c79c3c25-9f66-4ad8-b0f6-d96484e877f4	true	access.token.claim
c79c3c25-9f66-4ad8-b0f6-d96484e877f4	website	claim.name
c79c3c25-9f66-4ad8-b0f6-d96484e877f4	String	jsonType.label
f4b4eae0-ae48-4d18-b487-0bcdafba531f	true	introspection.token.claim
f4b4eae0-ae48-4d18-b487-0bcdafba531f	true	userinfo.token.claim
f4b4eae0-ae48-4d18-b487-0bcdafba531f	profile	user.attribute
f4b4eae0-ae48-4d18-b487-0bcdafba531f	true	id.token.claim
f4b4eae0-ae48-4d18-b487-0bcdafba531f	true	access.token.claim
f4b4eae0-ae48-4d18-b487-0bcdafba531f	profile	claim.name
f4b4eae0-ae48-4d18-b487-0bcdafba531f	String	jsonType.label
4ed4c795-8f84-41ed-a55e-1db1b4055847	true	introspection.token.claim
4ed4c795-8f84-41ed-a55e-1db1b4055847	true	userinfo.token.claim
4ed4c795-8f84-41ed-a55e-1db1b4055847	emailVerified	user.attribute
4ed4c795-8f84-41ed-a55e-1db1b4055847	true	id.token.claim
4ed4c795-8f84-41ed-a55e-1db1b4055847	true	access.token.claim
4ed4c795-8f84-41ed-a55e-1db1b4055847	email_verified	claim.name
4ed4c795-8f84-41ed-a55e-1db1b4055847	boolean	jsonType.label
c8cc0c8a-0ad8-499c-bc37-324601f93b1e	true	introspection.token.claim
c8cc0c8a-0ad8-499c-bc37-324601f93b1e	true	userinfo.token.claim
c8cc0c8a-0ad8-499c-bc37-324601f93b1e	email	user.attribute
c8cc0c8a-0ad8-499c-bc37-324601f93b1e	true	id.token.claim
c8cc0c8a-0ad8-499c-bc37-324601f93b1e	true	access.token.claim
c8cc0c8a-0ad8-499c-bc37-324601f93b1e	email	claim.name
c8cc0c8a-0ad8-499c-bc37-324601f93b1e	String	jsonType.label
1064536d-1132-4ee2-823d-29c955d18802	formatted	user.attribute.formatted
1064536d-1132-4ee2-823d-29c955d18802	country	user.attribute.country
1064536d-1132-4ee2-823d-29c955d18802	true	introspection.token.claim
1064536d-1132-4ee2-823d-29c955d18802	postal_code	user.attribute.postal_code
1064536d-1132-4ee2-823d-29c955d18802	true	userinfo.token.claim
1064536d-1132-4ee2-823d-29c955d18802	street	user.attribute.street
1064536d-1132-4ee2-823d-29c955d18802	true	id.token.claim
1064536d-1132-4ee2-823d-29c955d18802	region	user.attribute.region
1064536d-1132-4ee2-823d-29c955d18802	true	access.token.claim
1064536d-1132-4ee2-823d-29c955d18802	locality	user.attribute.locality
8e04ad85-7259-4cd3-9971-5c6a06fc436f	true	introspection.token.claim
8e04ad85-7259-4cd3-9971-5c6a06fc436f	true	userinfo.token.claim
8e04ad85-7259-4cd3-9971-5c6a06fc436f	phoneNumberVerified	user.attribute
8e04ad85-7259-4cd3-9971-5c6a06fc436f	true	id.token.claim
8e04ad85-7259-4cd3-9971-5c6a06fc436f	true	access.token.claim
8e04ad85-7259-4cd3-9971-5c6a06fc436f	phone_number_verified	claim.name
8e04ad85-7259-4cd3-9971-5c6a06fc436f	boolean	jsonType.label
ec258bfe-cc72-487c-9b87-95a320b1df4a	true	introspection.token.claim
ec258bfe-cc72-487c-9b87-95a320b1df4a	true	userinfo.token.claim
ec258bfe-cc72-487c-9b87-95a320b1df4a	phoneNumber	user.attribute
ec258bfe-cc72-487c-9b87-95a320b1df4a	true	id.token.claim
ec258bfe-cc72-487c-9b87-95a320b1df4a	true	access.token.claim
ec258bfe-cc72-487c-9b87-95a320b1df4a	phone_number	claim.name
ec258bfe-cc72-487c-9b87-95a320b1df4a	String	jsonType.label
6406534a-81e4-4b74-aba4-46b8c3b91047	true	introspection.token.claim
6406534a-81e4-4b74-aba4-46b8c3b91047	true	access.token.claim
d7d723ee-c0d3-4aaf-b01c-e2fd84ed343b	true	introspection.token.claim
d7d723ee-c0d3-4aaf-b01c-e2fd84ed343b	true	multivalued
d7d723ee-c0d3-4aaf-b01c-e2fd84ed343b	foo	user.attribute
d7d723ee-c0d3-4aaf-b01c-e2fd84ed343b	true	access.token.claim
d7d723ee-c0d3-4aaf-b01c-e2fd84ed343b	realm_access.roles	claim.name
d7d723ee-c0d3-4aaf-b01c-e2fd84ed343b	String	jsonType.label
fe7e69c3-e82c-4252-bf89-835391d7d842	true	introspection.token.claim
fe7e69c3-e82c-4252-bf89-835391d7d842	true	multivalued
fe7e69c3-e82c-4252-bf89-835391d7d842	foo	user.attribute
fe7e69c3-e82c-4252-bf89-835391d7d842	true	access.token.claim
fe7e69c3-e82c-4252-bf89-835391d7d842	resource_access.${client_id}.roles	claim.name
fe7e69c3-e82c-4252-bf89-835391d7d842	String	jsonType.label
229f363e-41e5-4ece-b400-5cd0a78198ba	true	introspection.token.claim
229f363e-41e5-4ece-b400-5cd0a78198ba	true	access.token.claim
1e8df5e7-6f06-44d0-a93e-030d83671274	true	introspection.token.claim
1e8df5e7-6f06-44d0-a93e-030d83671274	true	userinfo.token.claim
1e8df5e7-6f06-44d0-a93e-030d83671274	username	user.attribute
1e8df5e7-6f06-44d0-a93e-030d83671274	true	id.token.claim
1e8df5e7-6f06-44d0-a93e-030d83671274	true	access.token.claim
1e8df5e7-6f06-44d0-a93e-030d83671274	upn	claim.name
1e8df5e7-6f06-44d0-a93e-030d83671274	String	jsonType.label
7e0da82e-a7e2-4ac6-a8ba-5af9d1c24133	true	introspection.token.claim
7e0da82e-a7e2-4ac6-a8ba-5af9d1c24133	true	multivalued
7e0da82e-a7e2-4ac6-a8ba-5af9d1c24133	foo	user.attribute
7e0da82e-a7e2-4ac6-a8ba-5af9d1c24133	true	id.token.claim
7e0da82e-a7e2-4ac6-a8ba-5af9d1c24133	true	access.token.claim
7e0da82e-a7e2-4ac6-a8ba-5af9d1c24133	groups	claim.name
7e0da82e-a7e2-4ac6-a8ba-5af9d1c24133	String	jsonType.label
ce10ba34-8b6a-436e-bf4b-106fe2bbb5f8	true	introspection.token.claim
ce10ba34-8b6a-436e-bf4b-106fe2bbb5f8	true	id.token.claim
ce10ba34-8b6a-436e-bf4b-106fe2bbb5f8	true	access.token.claim
50ba2287-5d55-4fec-a204-b1b4b709dd9a	true	introspection.token.claim
50ba2287-5d55-4fec-a204-b1b4b709dd9a	true	access.token.claim
996fb432-86a3-4474-a614-715cbb05bcbc	AUTH_TIME	user.session.note
996fb432-86a3-4474-a614-715cbb05bcbc	true	introspection.token.claim
996fb432-86a3-4474-a614-715cbb05bcbc	true	id.token.claim
996fb432-86a3-4474-a614-715cbb05bcbc	true	access.token.claim
996fb432-86a3-4474-a614-715cbb05bcbc	auth_time	claim.name
996fb432-86a3-4474-a614-715cbb05bcbc	long	jsonType.label
42b6f5fc-6f67-4f2e-b16b-514da044d9ad	true	introspection.token.claim
42b6f5fc-6f67-4f2e-b16b-514da044d9ad	true	multivalued
42b6f5fc-6f67-4f2e-b16b-514da044d9ad	true	id.token.claim
42b6f5fc-6f67-4f2e-b16b-514da044d9ad	true	access.token.claim
42b6f5fc-6f67-4f2e-b16b-514da044d9ad	organization	claim.name
42b6f5fc-6f67-4f2e-b16b-514da044d9ad	String	jsonType.label
20df9a68-d2bc-4037-bf32-36511c750ed2	true	introspection.token.claim
20df9a68-d2bc-4037-bf32-36511c750ed2	true	userinfo.token.claim
20df9a68-d2bc-4037-bf32-36511c750ed2	locale	user.attribute
20df9a68-d2bc-4037-bf32-36511c750ed2	true	id.token.claim
20df9a68-d2bc-4037-bf32-36511c750ed2	true	access.token.claim
20df9a68-d2bc-4037-bf32-36511c750ed2	locale	claim.name
20df9a68-d2bc-4037-bf32-36511c750ed2	String	jsonType.label
2e7b2768-68e1-4ffa-b7c2-f3de8637d490	foo	user.attribute
2e7b2768-68e1-4ffa-b7c2-f3de8637d490	true	introspection.token.claim
2e7b2768-68e1-4ffa-b7c2-f3de8637d490	true	access.token.claim
2e7b2768-68e1-4ffa-b7c2-f3de8637d490	realm_access.roles	claim.name
2e7b2768-68e1-4ffa-b7c2-f3de8637d490	String	jsonType.label
2e7b2768-68e1-4ffa-b7c2-f3de8637d490	true	multivalued
30c113e7-89df-4522-b5b3-d47024eb0064	true	introspection.token.claim
30c113e7-89df-4522-b5b3-d47024eb0064	true	userinfo.token.claim
30c113e7-89df-4522-b5b3-d47024eb0064	email	user.attribute
30c113e7-89df-4522-b5b3-d47024eb0064	true	id.token.claim
30c113e7-89df-4522-b5b3-d47024eb0064	true	access.token.claim
30c113e7-89df-4522-b5b3-d47024eb0064	email	claim.name
30c113e7-89df-4522-b5b3-d47024eb0064	String	jsonType.label
47fc57f9-f0a3-4df9-be22-ca2f6f4e0fd6	true	introspection.token.claim
47fc57f9-f0a3-4df9-be22-ca2f6f4e0fd6	true	userinfo.token.claim
47fc57f9-f0a3-4df9-be22-ca2f6f4e0fd6	lastName	user.attribute
47fc57f9-f0a3-4df9-be22-ca2f6f4e0fd6	true	id.token.claim
47fc57f9-f0a3-4df9-be22-ca2f6f4e0fd6	true	access.token.claim
47fc57f9-f0a3-4df9-be22-ca2f6f4e0fd6	family_name	claim.name
47fc57f9-f0a3-4df9-be22-ca2f6f4e0fd6	String	jsonType.label
9d9d926a-4ccf-41f1-b361-93c8dd9d9dfc	true	id.token.claim
9d9d926a-4ccf-41f1-b361-93c8dd9d9dfc	true	introspection.token.claim
9d9d926a-4ccf-41f1-b361-93c8dd9d9dfc	true	access.token.claim
9d9d926a-4ccf-41f1-b361-93c8dd9d9dfc	true	userinfo.token.claim
d55136b5-8c20-4086-af2b-ca2cba86a124	true	introspection.token.claim
d55136b5-8c20-4086-af2b-ca2cba86a124	true	userinfo.token.claim
d55136b5-8c20-4086-af2b-ca2cba86a124	username	user.attribute
d55136b5-8c20-4086-af2b-ca2cba86a124	true	id.token.claim
d55136b5-8c20-4086-af2b-ca2cba86a124	true	access.token.claim
d55136b5-8c20-4086-af2b-ca2cba86a124	preferred_username	claim.name
d55136b5-8c20-4086-af2b-ca2cba86a124	String	jsonType.label
e7e8497e-b863-43bd-a247-cd087bd484ea	true	introspection.token.claim
e7e8497e-b863-43bd-a247-cd087bd484ea	true	multivalued
e7e8497e-b863-43bd-a247-cd087bd484ea	foo	user.attribute
e7e8497e-b863-43bd-a247-cd087bd484ea	true	id.token.claim
e7e8497e-b863-43bd-a247-cd087bd484ea	true	access.token.claim
e7e8497e-b863-43bd-a247-cd087bd484ea	groups	claim.name
e7e8497e-b863-43bd-a247-cd087bd484ea	String	jsonType.label
0255237c-7a1e-4b7c-b5c6-713536b829c3	clientHost	user.session.note
0255237c-7a1e-4b7c-b5c6-713536b829c3	true	introspection.token.claim
0255237c-7a1e-4b7c-b5c6-713536b829c3	true	id.token.claim
0255237c-7a1e-4b7c-b5c6-713536b829c3	true	access.token.claim
0255237c-7a1e-4b7c-b5c6-713536b829c3	clientHost	claim.name
0255237c-7a1e-4b7c-b5c6-713536b829c3	String	jsonType.label
2f129c36-154b-4526-9d1f-f39d8e71b09c	clientAddress	user.session.note
2f129c36-154b-4526-9d1f-f39d8e71b09c	true	introspection.token.claim
2f129c36-154b-4526-9d1f-f39d8e71b09c	true	id.token.claim
2f129c36-154b-4526-9d1f-f39d8e71b09c	true	access.token.claim
2f129c36-154b-4526-9d1f-f39d8e71b09c	clientAddress	claim.name
2f129c36-154b-4526-9d1f-f39d8e71b09c	String	jsonType.label
86b64975-fc0a-43c2-b793-2e6d6645819a	client_id	user.session.note
86b64975-fc0a-43c2-b793-2e6d6645819a	true	introspection.token.claim
86b64975-fc0a-43c2-b793-2e6d6645819a	true	id.token.claim
86b64975-fc0a-43c2-b793-2e6d6645819a	true	access.token.claim
86b64975-fc0a-43c2-b793-2e6d6645819a	client_id	claim.name
86b64975-fc0a-43c2-b793-2e6d6645819a	String	jsonType.label
3fe2ea25-438d-4b36-9919-bd069dc080df	true	introspection.token.claim
3fe2ea25-438d-4b36-9919-bd069dc080df	true	userinfo.token.claim
3fe2ea25-438d-4b36-9919-bd069dc080df	emailVerified	user.attribute
3fe2ea25-438d-4b36-9919-bd069dc080df	true	id.token.claim
3fe2ea25-438d-4b36-9919-bd069dc080df	true	access.token.claim
3fe2ea25-438d-4b36-9919-bd069dc080df	email_verified	claim.name
3fe2ea25-438d-4b36-9919-bd069dc080df	boolean	jsonType.label
446fb4c3-f766-4abd-8e15-3be87a6d2535	foo	user.attribute
446fb4c3-f766-4abd-8e15-3be87a6d2535	true	introspection.token.claim
446fb4c3-f766-4abd-8e15-3be87a6d2535	true	access.token.claim
446fb4c3-f766-4abd-8e15-3be87a6d2535	resource_access.${client_id}.roles	claim.name
446fb4c3-f766-4abd-8e15-3be87a6d2535	String	jsonType.label
446fb4c3-f766-4abd-8e15-3be87a6d2535	true	multivalued
5253c017-8fb2-4eef-9bda-cfdc3ef88172	true	id.token.claim
5253c017-8fb2-4eef-9bda-cfdc3ef88172	true	introspection.token.claim
5253c017-8fb2-4eef-9bda-cfdc3ef88172	true	access.token.claim
5253c017-8fb2-4eef-9bda-cfdc3ef88172	true	userinfo.token.claim
582bfbb4-fad6-464b-8975-346d11f2cd7b	true	introspection.token.claim
582bfbb4-fad6-464b-8975-346d11f2cd7b	true	userinfo.token.claim
582bfbb4-fad6-464b-8975-346d11f2cd7b	nickname	user.attribute
582bfbb4-fad6-464b-8975-346d11f2cd7b	true	id.token.claim
582bfbb4-fad6-464b-8975-346d11f2cd7b	true	access.token.claim
582bfbb4-fad6-464b-8975-346d11f2cd7b	nickname	claim.name
582bfbb4-fad6-464b-8975-346d11f2cd7b	String	jsonType.label
6f8272b6-6493-4313-8347-bb2828e07c9e	true	introspection.token.claim
6f8272b6-6493-4313-8347-bb2828e07c9e	true	userinfo.token.claim
6f8272b6-6493-4313-8347-bb2828e07c9e	username	user.attribute
6f8272b6-6493-4313-8347-bb2828e07c9e	true	id.token.claim
6f8272b6-6493-4313-8347-bb2828e07c9e	true	access.token.claim
6f8272b6-6493-4313-8347-bb2828e07c9e	preferred_username	claim.name
6f8272b6-6493-4313-8347-bb2828e07c9e	String	jsonType.label
8648f9e7-63ba-4693-88b9-8bedd1e6a687	true	introspection.token.claim
8648f9e7-63ba-4693-88b9-8bedd1e6a687	true	userinfo.token.claim
8648f9e7-63ba-4693-88b9-8bedd1e6a687	lastName	user.attribute
8648f9e7-63ba-4693-88b9-8bedd1e6a687	true	id.token.claim
8648f9e7-63ba-4693-88b9-8bedd1e6a687	true	access.token.claim
8648f9e7-63ba-4693-88b9-8bedd1e6a687	family_name	claim.name
8648f9e7-63ba-4693-88b9-8bedd1e6a687	String	jsonType.label
bbc21ab2-1e57-490e-89eb-ccfa612fc603	true	introspection.token.claim
bbc21ab2-1e57-490e-89eb-ccfa612fc603	true	userinfo.token.claim
bbc21ab2-1e57-490e-89eb-ccfa612fc603	email	user.attribute
bbc21ab2-1e57-490e-89eb-ccfa612fc603	true	id.token.claim
bbc21ab2-1e57-490e-89eb-ccfa612fc603	true	access.token.claim
bbc21ab2-1e57-490e-89eb-ccfa612fc603	email	claim.name
bbc21ab2-1e57-490e-89eb-ccfa612fc603	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
503310e2-70f4-445d-bfe0-0c00deb5ea32	60	300	300	\N	\N	\N	t	f	0	\N	hackaton	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	14577c13-02e1-456f-a07b-4d2db438e606	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f2901a84-4bfc-4d3e-98af-d766afa5f6d8	6c0cd7ad-fb92-483c-a86a-c90c3e809a7f	cce45f3c-249f-47dd-a8e0-2759d25228c2	c8f47c36-0f64-45b8-ab1e-eb3caf741ea3	05bba604-0a3a-4a4c-b6fd-d8bc5a745ff8	2592000	f	900	t	f	441d2f1a-49eb-40e6-825a-d939e79184a1	0	f	0	0	ffda1a5e-2918-4a71-9003-a340361d99eb
f3481901-3ac1-43bb-b067-1ac965a8d282	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d0055a30-e19a-4ef1-ba2b-b7a5acf9648c	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2bb74c26-f485-4bdf-b23a-a7a79c4d51cd	44f600ce-1655-4e9e-a84d-d774ed1e3ce7	a93745d1-b83a-45b2-97e0-d7a933d59cd5	9b51756b-853f-4111-8e20-93e28254aa80	f73ee8df-eed0-426b-9cd0-80f8f485c986	2592000	f	900	t	f	8e79df5e-1261-48ab-9723-e0f3784077f7	0	f	0	0	bccaa811-7558-4ba0-b883-1987bb1e4314
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	f3481901-3ac1-43bb-b067-1ac965a8d282	
_browser_header.xContentTypeOptions	f3481901-3ac1-43bb-b067-1ac965a8d282	nosniff
_browser_header.referrerPolicy	f3481901-3ac1-43bb-b067-1ac965a8d282	no-referrer
_browser_header.xRobotsTag	f3481901-3ac1-43bb-b067-1ac965a8d282	none
_browser_header.xFrameOptions	f3481901-3ac1-43bb-b067-1ac965a8d282	SAMEORIGIN
_browser_header.contentSecurityPolicy	f3481901-3ac1-43bb-b067-1ac965a8d282	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	f3481901-3ac1-43bb-b067-1ac965a8d282	1; mode=block
_browser_header.strictTransportSecurity	f3481901-3ac1-43bb-b067-1ac965a8d282	max-age=31536000; includeSubDomains
bruteForceProtected	f3481901-3ac1-43bb-b067-1ac965a8d282	false
permanentLockout	f3481901-3ac1-43bb-b067-1ac965a8d282	false
maxTemporaryLockouts	f3481901-3ac1-43bb-b067-1ac965a8d282	0
bruteForceStrategy	f3481901-3ac1-43bb-b067-1ac965a8d282	MULTIPLE
maxFailureWaitSeconds	f3481901-3ac1-43bb-b067-1ac965a8d282	900
minimumQuickLoginWaitSeconds	f3481901-3ac1-43bb-b067-1ac965a8d282	60
waitIncrementSeconds	f3481901-3ac1-43bb-b067-1ac965a8d282	60
quickLoginCheckMilliSeconds	f3481901-3ac1-43bb-b067-1ac965a8d282	1000
maxDeltaTimeSeconds	f3481901-3ac1-43bb-b067-1ac965a8d282	43200
failureFactor	f3481901-3ac1-43bb-b067-1ac965a8d282	30
realmReusableOtpCode	f3481901-3ac1-43bb-b067-1ac965a8d282	false
firstBrokerLoginFlowId	f3481901-3ac1-43bb-b067-1ac965a8d282	3aa9076a-cdee-4c86-b42e-93b0aa659ee1
displayName	f3481901-3ac1-43bb-b067-1ac965a8d282	Keycloak
displayNameHtml	f3481901-3ac1-43bb-b067-1ac965a8d282	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	f3481901-3ac1-43bb-b067-1ac965a8d282	RS256
offlineSessionMaxLifespanEnabled	f3481901-3ac1-43bb-b067-1ac965a8d282	false
offlineSessionMaxLifespan	f3481901-3ac1-43bb-b067-1ac965a8d282	5184000
_browser_header.contentSecurityPolicyReportOnly	503310e2-70f4-445d-bfe0-0c00deb5ea32	
_browser_header.xContentTypeOptions	503310e2-70f4-445d-bfe0-0c00deb5ea32	nosniff
_browser_header.referrerPolicy	503310e2-70f4-445d-bfe0-0c00deb5ea32	no-referrer
_browser_header.xRobotsTag	503310e2-70f4-445d-bfe0-0c00deb5ea32	none
_browser_header.xFrameOptions	503310e2-70f4-445d-bfe0-0c00deb5ea32	SAMEORIGIN
_browser_header.contentSecurityPolicy	503310e2-70f4-445d-bfe0-0c00deb5ea32	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	503310e2-70f4-445d-bfe0-0c00deb5ea32	1; mode=block
_browser_header.strictTransportSecurity	503310e2-70f4-445d-bfe0-0c00deb5ea32	max-age=31536000; includeSubDomains
bruteForceProtected	503310e2-70f4-445d-bfe0-0c00deb5ea32	false
permanentLockout	503310e2-70f4-445d-bfe0-0c00deb5ea32	false
maxTemporaryLockouts	503310e2-70f4-445d-bfe0-0c00deb5ea32	0
bruteForceStrategy	503310e2-70f4-445d-bfe0-0c00deb5ea32	MULTIPLE
maxFailureWaitSeconds	503310e2-70f4-445d-bfe0-0c00deb5ea32	900
minimumQuickLoginWaitSeconds	503310e2-70f4-445d-bfe0-0c00deb5ea32	60
waitIncrementSeconds	503310e2-70f4-445d-bfe0-0c00deb5ea32	60
quickLoginCheckMilliSeconds	503310e2-70f4-445d-bfe0-0c00deb5ea32	1000
maxDeltaTimeSeconds	503310e2-70f4-445d-bfe0-0c00deb5ea32	43200
failureFactor	503310e2-70f4-445d-bfe0-0c00deb5ea32	30
realmReusableOtpCode	503310e2-70f4-445d-bfe0-0c00deb5ea32	false
defaultSignatureAlgorithm	503310e2-70f4-445d-bfe0-0c00deb5ea32	RS256
offlineSessionMaxLifespanEnabled	503310e2-70f4-445d-bfe0-0c00deb5ea32	false
offlineSessionMaxLifespan	503310e2-70f4-445d-bfe0-0c00deb5ea32	5184000
actionTokenGeneratedByAdminLifespan	503310e2-70f4-445d-bfe0-0c00deb5ea32	43200
actionTokenGeneratedByUserLifespan	503310e2-70f4-445d-bfe0-0c00deb5ea32	300
oauth2DeviceCodeLifespan	503310e2-70f4-445d-bfe0-0c00deb5ea32	600
oauth2DevicePollingInterval	503310e2-70f4-445d-bfe0-0c00deb5ea32	5
webAuthnPolicyRpEntityName	503310e2-70f4-445d-bfe0-0c00deb5ea32	keycloak
webAuthnPolicySignatureAlgorithms	503310e2-70f4-445d-bfe0-0c00deb5ea32	ES256,RS256
webAuthnPolicyRpId	503310e2-70f4-445d-bfe0-0c00deb5ea32	
webAuthnPolicyAttestationConveyancePreference	503310e2-70f4-445d-bfe0-0c00deb5ea32	not specified
webAuthnPolicyAuthenticatorAttachment	503310e2-70f4-445d-bfe0-0c00deb5ea32	not specified
webAuthnPolicyRequireResidentKey	503310e2-70f4-445d-bfe0-0c00deb5ea32	not specified
webAuthnPolicyUserVerificationRequirement	503310e2-70f4-445d-bfe0-0c00deb5ea32	not specified
webAuthnPolicyCreateTimeout	503310e2-70f4-445d-bfe0-0c00deb5ea32	0
webAuthnPolicyAvoidSameAuthenticatorRegister	503310e2-70f4-445d-bfe0-0c00deb5ea32	false
webAuthnPolicyRpEntityNamePasswordless	503310e2-70f4-445d-bfe0-0c00deb5ea32	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	503310e2-70f4-445d-bfe0-0c00deb5ea32	ES256,RS256
webAuthnPolicyRpIdPasswordless	503310e2-70f4-445d-bfe0-0c00deb5ea32	
webAuthnPolicyAttestationConveyancePreferencePasswordless	503310e2-70f4-445d-bfe0-0c00deb5ea32	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	503310e2-70f4-445d-bfe0-0c00deb5ea32	not specified
webAuthnPolicyRequireResidentKeyPasswordless	503310e2-70f4-445d-bfe0-0c00deb5ea32	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	503310e2-70f4-445d-bfe0-0c00deb5ea32	not specified
webAuthnPolicyCreateTimeoutPasswordless	503310e2-70f4-445d-bfe0-0c00deb5ea32	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	503310e2-70f4-445d-bfe0-0c00deb5ea32	false
cibaBackchannelTokenDeliveryMode	503310e2-70f4-445d-bfe0-0c00deb5ea32	poll
cibaExpiresIn	503310e2-70f4-445d-bfe0-0c00deb5ea32	120
cibaInterval	503310e2-70f4-445d-bfe0-0c00deb5ea32	5
cibaAuthRequestedUserHint	503310e2-70f4-445d-bfe0-0c00deb5ea32	login_hint
parRequestUriLifespan	503310e2-70f4-445d-bfe0-0c00deb5ea32	60
firstBrokerLoginFlowId	503310e2-70f4-445d-bfe0-0c00deb5ea32	0fbc65da-ec9c-4d86-be80-b485f57d1636
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
f3481901-3ac1-43bb-b067-1ac965a8d282	jboss-logging
503310e2-70f4-445d-bfe0-0c00deb5ea32	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	f3481901-3ac1-43bb-b067-1ac965a8d282
password	password	t	t	503310e2-70f4-445d-bfe0-0c00deb5ea32
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
b904d985-b7d6-4352-b9aa-42626d8ce09e	/realms/master/account/*
cc320807-24a8-4be4-949b-4b75fcdb982c	/realms/master/account/*
8cc74036-ce0b-40fb-bad4-213c98d2cef6	/admin/master/console/*
f4fa91de-2cb6-4c33-9c98-18d1fc462c33	/realms/hackaton/account/*
cc8ea444-0ef6-47dc-94c8-9baf324015d3	/realms/hackaton/account/*
56129fd8-266b-47e1-8227-c4dcfbc9f44e	/admin/hackaton/console/*
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
d4f45e5a-4d6a-4483-9edf-0dbdaf913e6f	VERIFY_EMAIL	Verify Email	f3481901-3ac1-43bb-b067-1ac965a8d282	t	f	VERIFY_EMAIL	50
84273228-982d-400f-9c78-80c2c90f8ece	UPDATE_PROFILE	Update Profile	f3481901-3ac1-43bb-b067-1ac965a8d282	t	f	UPDATE_PROFILE	40
132e977d-e2f5-4c77-a6b6-4f01530b5e3a	CONFIGURE_TOTP	Configure OTP	f3481901-3ac1-43bb-b067-1ac965a8d282	t	f	CONFIGURE_TOTP	10
37b9e479-0b69-4576-abaa-46d71b2a702e	UPDATE_PASSWORD	Update Password	f3481901-3ac1-43bb-b067-1ac965a8d282	t	f	UPDATE_PASSWORD	30
66a7eb45-b25e-487a-8320-9f6e47c71648	TERMS_AND_CONDITIONS	Terms and Conditions	f3481901-3ac1-43bb-b067-1ac965a8d282	f	f	TERMS_AND_CONDITIONS	20
b6ee870d-aa28-42a2-9046-8101aa34c5cc	delete_account	Delete Account	f3481901-3ac1-43bb-b067-1ac965a8d282	f	f	delete_account	60
4f81157d-147b-4df6-8de1-44d50ecd016e	delete_credential	Delete Credential	f3481901-3ac1-43bb-b067-1ac965a8d282	t	f	delete_credential	100
0420659e-0f33-4ad3-9a68-3d894b179ea3	update_user_locale	Update User Locale	f3481901-3ac1-43bb-b067-1ac965a8d282	t	f	update_user_locale	1000
1ab40a2e-84b0-45be-bb5d-0df6bd676c61	webauthn-register	Webauthn Register	f3481901-3ac1-43bb-b067-1ac965a8d282	t	f	webauthn-register	70
1409ea85-6c27-43e9-805b-ec86d213fa7c	webauthn-register-passwordless	Webauthn Register Passwordless	f3481901-3ac1-43bb-b067-1ac965a8d282	t	f	webauthn-register-passwordless	80
d4e48a25-bc89-4bc4-b450-47631ca6c88d	VERIFY_PROFILE	Verify Profile	f3481901-3ac1-43bb-b067-1ac965a8d282	t	f	VERIFY_PROFILE	90
15513e8b-b11f-4a83-a04d-64944d6288c9	VERIFY_EMAIL	Verify Email	503310e2-70f4-445d-bfe0-0c00deb5ea32	t	f	VERIFY_EMAIL	50
10eddcae-b9f3-4c1f-9d6c-01e5567f9e52	UPDATE_PROFILE	Update Profile	503310e2-70f4-445d-bfe0-0c00deb5ea32	t	f	UPDATE_PROFILE	40
20ed5245-bfaf-4ba5-baa2-05dd731ba914	CONFIGURE_TOTP	Configure OTP	503310e2-70f4-445d-bfe0-0c00deb5ea32	t	f	CONFIGURE_TOTP	10
81a4c8b7-b3b7-4860-94f6-7278071a5544	UPDATE_PASSWORD	Update Password	503310e2-70f4-445d-bfe0-0c00deb5ea32	t	f	UPDATE_PASSWORD	30
33511fcf-742c-484e-a96a-eaf7afd76a65	TERMS_AND_CONDITIONS	Terms and Conditions	503310e2-70f4-445d-bfe0-0c00deb5ea32	f	f	TERMS_AND_CONDITIONS	20
3f6f2c52-ec9d-49dc-b601-3b403cd8e408	delete_account	Delete Account	503310e2-70f4-445d-bfe0-0c00deb5ea32	f	f	delete_account	60
1faf74f3-8c53-40f6-9c22-8667b7bdf292	delete_credential	Delete Credential	503310e2-70f4-445d-bfe0-0c00deb5ea32	t	f	delete_credential	100
14f5d832-1fb5-43bf-a759-7907aff94776	update_user_locale	Update User Locale	503310e2-70f4-445d-bfe0-0c00deb5ea32	t	f	update_user_locale	1000
6bec7c63-18be-4180-949e-7207b27391f6	webauthn-register	Webauthn Register	503310e2-70f4-445d-bfe0-0c00deb5ea32	t	f	webauthn-register	70
dd913d6f-54b8-498d-9e42-610f872b37b2	webauthn-register-passwordless	Webauthn Register Passwordless	503310e2-70f4-445d-bfe0-0c00deb5ea32	t	f	webauthn-register-passwordless	80
b05471d2-0a2d-4ccf-9b30-c498c69966ba	VERIFY_PROFILE	Verify Profile	503310e2-70f4-445d-bfe0-0c00deb5ea32	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
e47bac88-e9a6-4e8a-9831-bf499f39a2a9	Default Policy	A policy that grants access only for users within this realm	js	0	0	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
5ddcbf29-cc76-42b4-9100-a3b00cb572e0	Default Permission	A permission that applies to the default resource type	resource	1	0	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
adf88a4d-601b-405c-b472-ae07a66ae4e3	Default Resource	urn:hackaton-app:resources:default	\N	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
adf88a4d-601b-405c-b472-ae07a66ae4e3	/*
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
cc320807-24a8-4be4-949b-4b75fcdb982c	3d0379f3-17a4-444a-af80-fa58caaa48b0
cc320807-24a8-4be4-949b-4b75fcdb982c	e11e835b-a383-4a8e-961e-bd90a40858ff
cc8ea444-0ef6-47dc-94c8-9baf324015d3	a68d2d30-2838-4565-b05c-88dd2f5f29e2
cc8ea444-0ef6-47dc-94c8-9baf324015d3	5ccbb06d-f51c-432b-80a5-588e9922de8b
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	45b1f57d-e7f7-4a1d-8243-f16b764ce165	e880160b-0aa1-41bf-a4ec-f5e51f4bab4b	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
45b1f57d-e7f7-4a1d-8243-f16b764ce165	\N	3f18870c-4087-4e97-bc18-4513576f4082	f	t	\N	\N	\N	f3481901-3ac1-43bb-b067-1ac965a8d282	admin	1738200319479	\N	0
ff9ca1bc-849a-48cb-8236-77986d6434ba	root@email.com	root@email.com	t	t	\N	Root	Root	503310e2-70f4-445d-bfe0-0c00deb5ea32	root	1738200364043	\N	0
a9f3be3c-2835-4d16-866a-02b5564c5140	\N	04f8f649-5812-4854-b2df-8935eeaf6e36	f	t	\N	\N	\N	503310e2-70f4-445d-bfe0-0c00deb5ea32	service-account-hackaton-app	1738203547896	9e6d88e7-506f-4f29-95a9-2ae9aba46d59	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
bccaa811-7558-4ba0-b883-1987bb1e4314	45b1f57d-e7f7-4a1d-8243-f16b764ce165
17525f97-5bd5-4888-a665-d03406f2f16d	45b1f57d-e7f7-4a1d-8243-f16b764ce165
ffda1a5e-2918-4a71-9003-a340361d99eb	ff9ca1bc-849a-48cb-8236-77986d6434ba
fbef3d23-579b-40d4-b45c-adfe0db7a666	ff9ca1bc-849a-48cb-8236-77986d6434ba
7fc420b7-dcc5-46be-a0e9-4a4591ddaccb	ff9ca1bc-849a-48cb-8236-77986d6434ba
f015c524-c84e-4771-9561-8617233851a7	ff9ca1bc-849a-48cb-8236-77986d6434ba
100f0d47-7e3c-4512-89ae-ec5e9e838400	ff9ca1bc-849a-48cb-8236-77986d6434ba
eef4a17b-f018-4091-92dc-a9f2e8a9fb16	ff9ca1bc-849a-48cb-8236-77986d6434ba
1dceeb2d-c1db-4d31-8fda-ec6c71254a1f	ff9ca1bc-849a-48cb-8236-77986d6434ba
a4c4e904-caaf-4732-879b-765f9824db16	ff9ca1bc-849a-48cb-8236-77986d6434ba
9002b052-aacc-4e90-8299-99a85ae3b419	ff9ca1bc-849a-48cb-8236-77986d6434ba
8200d8b4-f015-4147-bac6-25fc7d181aa7	ff9ca1bc-849a-48cb-8236-77986d6434ba
377fd5fe-7691-4f7c-b352-bc2ac332fe79	ff9ca1bc-849a-48cb-8236-77986d6434ba
d6f13609-0084-4121-bd8a-c2714064ba58	ff9ca1bc-849a-48cb-8236-77986d6434ba
ba248ea5-1730-4dd9-8c9e-05e9f84421f2	ff9ca1bc-849a-48cb-8236-77986d6434ba
29f51dc1-8da0-4d18-a566-8da7d32e5120	ff9ca1bc-849a-48cb-8236-77986d6434ba
9cdd04d1-48ae-4e39-8a1c-e5d747900761	ff9ca1bc-849a-48cb-8236-77986d6434ba
45a8b1cb-1733-4a69-bd9f-84b8804c0c0f	ff9ca1bc-849a-48cb-8236-77986d6434ba
121f836f-d875-4434-98de-3ebd6b63e332	ff9ca1bc-849a-48cb-8236-77986d6434ba
cee80322-c935-4164-ad44-5f0761ab2b53	ff9ca1bc-849a-48cb-8236-77986d6434ba
983de620-d6ac-4fc7-820a-e184d3779c1e	ff9ca1bc-849a-48cb-8236-77986d6434ba
e4391be3-a0f4-449b-94a5-09830968ed00	ff9ca1bc-849a-48cb-8236-77986d6434ba
44d56347-f949-43ba-8d75-4b5076238651	ff9ca1bc-849a-48cb-8236-77986d6434ba
b0d63051-4293-452b-aa17-0e726abbe01b	ff9ca1bc-849a-48cb-8236-77986d6434ba
df42e096-50a8-4550-95c6-ab86456b5d44	ff9ca1bc-849a-48cb-8236-77986d6434ba
5ccbb06d-f51c-432b-80a5-588e9922de8b	ff9ca1bc-849a-48cb-8236-77986d6434ba
e3f78650-7f2d-4794-90b4-13c6864a0674	ff9ca1bc-849a-48cb-8236-77986d6434ba
2a2edc5f-5400-4612-a419-cc888e5b8e49	ff9ca1bc-849a-48cb-8236-77986d6434ba
a8d30b6f-d412-43ae-af54-f3ba1796b5bb	ff9ca1bc-849a-48cb-8236-77986d6434ba
657f3e73-cdcc-468a-9b88-4a3ad1efdb5e	ff9ca1bc-849a-48cb-8236-77986d6434ba
a68d2d30-2838-4565-b05c-88dd2f5f29e2	ff9ca1bc-849a-48cb-8236-77986d6434ba
ffda1a5e-2918-4a71-9003-a340361d99eb	a9f3be3c-2835-4d16-866a-02b5564c5140
e3824ebf-d5c1-445a-9cb7-9af28c2e7b64	a9f3be3c-2835-4d16-866a-02b5564c5140
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
8cc74036-ce0b-40fb-bad4-213c98d2cef6	+
56129fd8-266b-47e1-8227-c4dcfbc9f44e	+
9e6d88e7-506f-4f29-95a9-2ae9aba46d59	/*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

